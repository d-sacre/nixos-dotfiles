{ config, pkgs, pkgs-unstable, systemSettings, userSettings, ... }:

{

  imports = [
    ./apps/browser/firefox/firefox.nix
    ./apps/browser/chromium/chromium.nix
    ./apps/browser/brave/brave.nix
  ];

  # DESCRIPTION: Make sure that home manager can install unfree packages
  # SOURCES:
  # https://nixos.wiki/wiki/Unfree_Software
  # https://discourse.nixos.org/t/unfree-packages-on-flake-based-home-manager/30231 
  nixpkgs.config.allowUnfreePredicate = _: true;
  # inputs.nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

  # DESCRIPTION: Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = userSettings.userName;
    homeDirectory = "/home/" + userSettings.userName;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    # REMARK: Should use its own variable in the future to prevent incompatibility 
    stateVersion = systemSettings.version; # Please read the comment before changing.
  };

  # DESCRIPTION: The home.packages option allows you to install Nix packages into your
  # environment.
  # REMARK: Split into different package sets to allow for parallel usage of
  # stable and unstable versions
  # WARNING: Mixing stable and unstable can lead to issues, since the evaluator is based upon one version 
  # (in this case: stable), whcih can lead to missing functionality when trying to install unstable content
  home.packages = ( 
    # DESCRIPTION: Install packages from STABLE branch
    with pkgs; [ 
      # Typesetting
      texstudio

      # General Development
      # DESCRIPTION: Install VSCodium instead of VSCode and add some extensions
      (
        vscode-with-extensions.override {
          vscode = vscodium;
          vscodeExtensions = with vscode-extensions; [
            bbenoist.nix
            ms-python.python
            ms-vscode.cpptools # REMARK: Unfree license
            ms-vscode.cmake-tools
          ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "godot-tools";
              publisher = "geequlim";
              version = "2.0.0";
              sha256 = "sha256-6lSpx6GooZm6SfUOjooP8mHchu8w38an8Bc2tjYaVfw=";
            }
          ];
        }
      )

      # Game Development
      godot3
      godot3-export-templates
      # REMARK: Installing two Godot Version side by side is not possible due to issue with icon
      # ERROR MESSAGE:
      # > error: collision between `/nix/store/9g7kvimphj88yicmnwvj5rd6ifqib1wb-godot4-4.2.2-stable/share/icons/hicolor/scalable/apps/godot.svg' and 
      # `/nix/store/5y6y6bsnxk1ijb2rbs7zx5faxvlxxc00-godot3-3.5.2/share/icons/hicolor/scalable/apps/godot.svg'
      # godot_4
      # godot_4-export-templates
    ]
  ) 

  ++ 

  ( # DESCRIPTION: Install packages from UNSTABLE branch
    with pkgs-unstable; [ 
        # Typesetting
        texliveFull
    ]
  );

  # # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # # plain files is through 'home.file'.
  # home.file = {
  #   # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  #   # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  #   # # symlink to the Nix store copy.
  #   # ".screenrc".source = dotfiles/screenrc;

  #   # # You can also set the file content immediately.
  #   # ".gradle/gradle.properties".text = ''
  #   #   org.gradle.console=verbose
  #   #   org.gradle.daemon.idletimeout=3600000
  #   # '';
  # };

  # # Home Manager can also manage your environment variables through
  # # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # # Manager then you have to manually source 'hm-session-vars.sh' located at
  # # either
  # #
  # #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # #
  # # or
  # #
  # #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # #
  # # or
  # #
  # #  /etc/profiles/per-user/nixos/etc/profile.d/hm-session-vars.sh
  # #
  # home.sessionVariables = {
  #   # EDITOR = "emacs";
  # };

  # DESCRIPTION: Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
