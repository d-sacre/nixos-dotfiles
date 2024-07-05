# DESCRIPTION: Derived from SOURCES:
# https://github.com/NapoleonWils0n/nixos-dotfiles/blob/master/nixos-dotfiles.org
# https://github.com/mahmoudk1000/nix-config/blob/main/modules/programs/firefox.nix
# https://discourse.nixos.org/t/firefox-extensions-with-home-manager/34108/2
# https://github.com/TLATER/dotfiles/blob/b39af91fbd13d338559a05d69f56c5a97f8c905d/home-config/config/graphical-applications/firefox.nix
# https://discourse.nixos.org/t/how-can-i-pass-inputs-as-specialargs-in-a-flake/39560

{ inputs, pkgs, ... }:
{
    
    programs.firefox = {
        enable = true;
        package = pkgs.firefox;
        policies = {
            #AppAutoUpdate = false;
            #CaptivePortal = false;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DisableFirefoxAccounts = true;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
            OfferToSaveLoginsDefault = false;
            PasswordManagerEnabled = false;
            FirefoxHome = {
                Search = true;
                Pocket = false;
                Snippets = false;
                TopSites = false;
                Highlights = false;
            };
        };
        profiles = {
            default = {
                isDefault = true;
                extraConfig = (builtins.readFile ./firefox_extra-config.js) + ''
                    // theme
                    user_pref("widget.content.gtk-theme-override", "Adwaita:dark");
                ''; 
                userChrome = (builtins.readFile ./firefox_user-chrome.css);
                settings = {
                    "extensions.autoDisableScopes" = 0;
                };

                # REMARK: Extensions in home-manager since Version 24.05 managed on a per profile basis
                extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
                    ghostery
                    noscript
                    ublock-origin
                ];
            };
        };
        
    };
}
