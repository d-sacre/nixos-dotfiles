{
    description = "My flake-based NixOS Configuration";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
    };

    outputs = {self, nixpkgs, ...}: 
    let
        # DESCRIPTION: Custom System and User Settings
        systemSettings = {
            system = "x86_64-linux";
            timeZone = "Europe/Berlin";
            locale = {
                default = "en_US.UTF-8";
                extra = "de_DE.UTF-8";
            };
            keyboard = {
                layout = "de";
                variant = "nodeadkeys";
            };
        };

        userSettings = {
            userName = "nixos";
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