{
    description = "My flake-based NixOS Configuration";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
    };

    outputs = {self, nixpkgs, ...}: 
    let
        # DESCRIPTION: Custom System Settings
        systemSettings = {
            hostName = "nixos";
            system = "x86_64-linux";
            version = "23.11";
            timeZone = "Europe/Berlin";
            locale = {
                default = "en_US.UTF-8";
                extra = "de_DE.UTF-8";
            };
            keyboard = {
                layout = "de";
                variant = "nodeadkeys";
            };
            installation = {
                type = "virtual"; # Allowed values: virtual,
                bootloader = {
                    device = "/dev/sda";
                };
            };
        };

        # DESCRIPTION: Custom User Settings
        userSettings = {
            userName = "nixos";
            desktopManager = "xfce"; # Allowed values: xfce
        };

        # DESCRIPTION: Nix Boilerplate
        lib = nixpkgs.lib;
    in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                system = systemSettings.system;
                modules = [ ./configuration.nix ];

                # DESCRIPTION: Pass special args to NixOS configuration
                # REMARK: Only works with Flakes!
                specialArgs = {
                    inherit systemSettings;
                    inherit userSettings;
                };
            };
        };
    };
}