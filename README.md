# nixos-dotfiles
A collection of dotfiles to configure NixOS

# Useful Things to Know
## Enable Flakes by Default
```nix
# DESCRIPTION: Enable flakes in <configuration.nix>
# SOURCE: https://www.youtube.com/watch?v=ACybVzRvDhs&t=543s
nix.settings.experimental-feautres = [ "nix-command" "flakes" ];
```
### REMARKS:
Requires execution of
```sh
sudo nixos-rebuild switch
```
to take effect.

## Change NixOS Configuration to the one Specified in Flake
```sh
nixos-rebuild switch --flake <FILEPATH>#<CONFIGNAME>
```
## REMARKS:
- If the system's hostname is identical to `<CONFIGNAME>` specified in the Flake, `#<CONFIGNAME>` can be omitted.
- If the Flake file name is `flake.nix`, one does not have to give a full file path, but only needs to specify the directory where the Flake is located.

**SOURCE:** 
Youtube Video: Libre Phoenix: You Should Use Flakes Right Away in NixOS![https://www.youtube.com/watch?v=ACybVzRvDhs&t=1346s](https://www.youtube.com/watch?v=ACybVzRvDhs&t=1346s)
