# nixos-dotfiles
A collection of dotfiles to configure NixOS

# Things to do after new Installation
- Setup git
```sh
git config --global user.name "USER_NAME"
git config --global user.email "USER_EMAIL"
```

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
sudo nixos-rebuild switch --flake <FILEPATH>#<CONFIGNAME>
```
### REMARKS:
- If the system's hostname is identical to `<CONFIGNAME>` specified in the Flake, `#<CONFIGNAME>` can be omitted.
- If the Flake file name is `flake.nix`, one does not have to give a full file path, but only needs to specify the directory where the Flake is located.

**SOURCE:**<br>
Youtube Video: Libre Phoenix: You Should Use Flakes Right Away in NixOS!<br>
[https://www.youtube.com/watch?v=ACybVzRvDhs&t=1346s](https://www.youtube.com/watch?v=ACybVzRvDhs&t=1346s)

## Activate Home Manager of Stable Branch in Standalone Mode
1. Open Terminal and add `nix-channel` for stable Home Manager Release 
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update
```
2. Install Home Manager
```sh
nix-shell '<home-manager>' -A install
```

## Running Home Manager
This flake requires the home manager to be run as follows:
```sh
home-manager switch --flake <PATH>#<USERNAME>
```
For example:
```sh
home-manager switch --flake .#nixos
```

Eventhough the username was identical with the name of the configuration, the configuration would otherwise not be found.

## Permission Issue with Flake.lock
While running `home-manager switch --flake`, there might be an error that the `flake.lock` file cannot be opened. This might happen if at some point in time a `sudo nixos-rebuild switch --flake` command has been run.<br> 
In some cases, it is sufficient to run `sudo nixos-rebuild switch --flake` to update all the flake settings properly. This should work for changes required by NixOS and/or Home Manager. If not, the other option is to set the permissions:
```sh
sudo chown <USERNAME> flake.lock
sudo chgrp users flake.lock
```
<br>**Source:** https://youtu.be/IiyBeR-Guqw?si=j4Jk_bOjpTWtI_SA&t=1001

## Warning: Option will be overwritten
Some changes like in the Firefox configuration will not work unless the backup option is set
```sh
home-manager switch -b backup --flake <PATH>#<USERNAME>
```

## Problems with hardware-configuration.nix
If the hardware configuration is faulty or will not be regenerate properly to take into account recent change, the file can be also forced to be recreated:
```sh
sudo nixos-generate-config
```
This creates `/etc/nixos/hardware-configuration.nix`. If the nixos-rebuild should be done with this flake located in the `~/.dotfiles directory, it has to be copied.
. The hardware configuration file is absolutely necessary; if deleted, one will only obtain an error message, and the file will not automatically be created.

## Mounted Devices might be no longer accessible after nixos-rebuild
Before running 
```sh
sudo nixos-rebuild switch
```
one should make sure that there are no devices mounted. Otherwise it might occur that the device will be unmountable after the rebuild due to ownership errors. Occured with ntfs formatted harddrive.

General Inspiration: <br>
https://gitlab.com/Oglo12/nixos-config<br><br>

Specific Inspiration (Power Saving, Greeter BG, Garbage Collection):<br>
https://github.com/AlexCKunze/NixOS-build/blob/main/etc/nixos/configuration.nix<br><br>

Custom Firefox Config:<br>
https://github.com/NapoleonWils0n/nixos-dotfiles/blob/master/nixos-dotfiles.org<br>
https://github.com/mahmoudk1000/nix-config
