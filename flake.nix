{
    description = "My flake-based NixOS Configuration";

    # REMARK: Allowing the usage of both stable and unstable releases.
    # WARNING: The system builder function and Home Manager equivalent are following 
    # the stable release. Trying to install an unstable package with an stable builder 
    # might fail due to incompatibility.

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        firefox-addons = { 
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; 
            inputs.nixpkgs.follows = "nixpkgs"; 
        };
    };

    outputs = inputs @ {self, nixpkgs, nixpkgs-unstable, firefox-addons, home-manager, ...}: 
    let
        inherit (self) outputs;
        # DESCRIPTION: Custom System Settings
        systemSettings = {
            hostName = "nixos";
            architecture = "x86_64-linux";
            version = "24.05";
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
                type = "native";#"virtual"; # Allowed values: virtual
                bootloader = {
                    device = "/dev/sda";
                };
            };
        };

        # DESCRIPTION: Custom User Settings
        userSettings = {
            userName = "nixe"; #"nixos";
            desktopManager = "xfce"; # Allowed values: xfce
        };

        # DESCRIPTION: Nix Boilerplate
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${systemSettings.architecture};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.architecture};
        
    in {
        nixosConfigurations = {
            tank = lib.nixosSystem {
                system = systemSettings.architecture;
                modules = [ 
                    ./configuration.nix 
                    # REMARK: It is not possible to use machine specific hardware configurations,
                    # since NixOS does not allow the usage of another path than the standard one
                    # ./machines/tank/hardware-configuration.nix
                ];

                # DESCRIPTION: Pass special args to NixOS configuration
                # REMARK: Only works with Flakes!
                specialArgs = {
                    inherit inputs self;
                    inherit systemSettings;
                    inherit userSettings;
                    inherit pkgs-unstable;
                };
            };

            virtualMachine = lib.nixosSystem {
                system = systemSettings.architecture;
                modules = [ 
                    ./configuration.nix 
                    ./machines/virtualMachine/virtualMachine.nix
                ];

                # DESCRIPTION: Pass special args to NixOS configuration
                # REMARK: Only works with Flakes!
                specialArgs = {
                    inherit inputs self;
                    inherit systemSettings;
                    inherit userSettings;
                    inherit pkgs-unstable;
                };
            };
        };

        homeConfigurations.tank = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];

            # DESCRIPTION: Pass special args to Home Manager configuration
            # REMARK: Only works with Flakes!
            extraSpecialArgs = {
                inherit inputs self;
                inherit systemSettings;
                inherit userSettings;
                inherit pkgs-unstable;
            };
        };

        homeConfigurations.razorblade = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ 
                ./home.nix 
                ./machines/razorblade/applications/blender.nix
            ];

            # DESCRIPTION: Pass special args to Home Manager configuration
            # REMARK: Only works with Flakes!
            extraSpecialArgs = {
                inherit inputs self;
                inherit systemSettings;
                inherit userSettings;
                inherit pkgs-unstable;
            };
        };
    };
}