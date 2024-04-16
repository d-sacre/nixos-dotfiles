{
    description = "My flake-based NixOS Configuration";

    # REMARK: Allowing the usage of both stable and unstable releases.
    # WARNING: The system builder function and Home Manager equivalent are following 
    # the stable release. Trying to install an unstable package with an stable builder 
    # might fail due to incompatibility.

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = {self, nixpkgs, nixpkgs-unstable, home-manager, ...}: 
    let
        # DESCRIPTION: Custom System Settings
        systemSettings = {
            hostName = "nixos";
            architecture = "x86_64-linux";
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
                type = "virtual"; # Allowed values: virtual
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
        pkgs = nixpkgs.legacyPackages.${systemSettings.architecture};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.architecture};
        
    in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                system = systemSettings.architecture;
                modules = [ ./configuration.nix ];

                # DESCRIPTION: Pass special args to NixOS configuration
                # REMARK: Only works with Flakes!
                specialArgs = {
                    inherit systemSettings;
                    inherit userSettings;
                    inherit pkgs-unstable;
                };
            };
        };

        homeConfigurations.${userSettings.userName} = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];

            # DESCRIPTION: Pass special args to Home Manager configuration
            # REMARK: Only works with Flakes!
            extraSpecialArgs = {
                inherit systemSettings;
                inherit userSettings;
                inherit pkgs-unstable;
            };
        };
    };
}