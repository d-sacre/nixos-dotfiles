{ config, pkgs, pkgs-unstable, systemSettings, userSettings, ... }:

{

  imports = [
    ./apps/browser/firefox/firefox.nix
  ];

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
  home.packages = ( with pkgs; [
    texstudio
    godot3
    godot3-export-templates
    godot_4
    godot_4-export-templates
  ]) 

  ++ 

  ( with pkgs-unstable; [
      texliveFull
  ]
  );

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-vscode.cpptools
      #forevolve.git-extensions-for-vs-code
      #geequlim.godot-tools
    ];
  };

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
