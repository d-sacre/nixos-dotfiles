# Derived from 
# https://github.com/NapoleonWils0n/nixos-dotfiles/blob/master/nixos-dotfiles.org
# https://github.com/mahmoudk1000/nix-config/blob/main/modules/programs/firefox.nix

{ pkgs, ... }:

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
            };
        };
    };
}
