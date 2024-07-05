{ config, pkgs, systemSettings, userSettings, ... }:

{
  # DESCRIPTION: Enable virtualization features if installation is as virtual machine
  # REMARK: Should be later put into an if-statement
  # SOURCE: https://nixos.wiki/wiki/VirtualBox
  virtualisation.virtualbox.host = if (systemSettings.installation.type == "virtual") then {
    enable = true;
    enableExtensionPack = true;
  } else {
    enable = false;
    enableExtensionPack = false; # REMARK: Requires nixpkgs.config.allowUnfree = true;
  };

  virtualisation.virtualbox.guest = if (systemSettings.installation.type == "virtual") then {
    enable = true;
    #x11 = true; # REMARK: does no longer work in 24.05
  } else {
    enable = false;
    #x11 = false; # REMARK: does no longer work in 24.05
  };

  users.extraGroups.vboxusers.members = if (systemSettings.installation.type == "virtual") then 
    [ "user-with-access-to-virtualbox" ]
  else [];
}