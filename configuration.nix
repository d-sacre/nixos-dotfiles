# Main System Configuration File
{ config, pkgs, systemSettings, userSettings, ... }:

{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = systemSettings.installation.bootloader.device;
    useOSProber = true;
  };

  networking = {
    hostName = systemSettings.hostName; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Enable networking
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = systemSettings.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.locale.default;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale.extra;
    LC_IDENTIFICATION = systemSettings.locale.extra;
    LC_MEASUREMENT = systemSettings.locale.extra;
    LC_MONETARY = systemSettings.locale.extra;
    LC_NAME = systemSettings.locale.extra;
    LC_NUMERIC = systemSettings.locale.extra;
    LC_PAPER = systemSettings.locale.extra;
    LC_TELEPHONE = systemSettings.locale.extra;
    LC_TIME = systemSettings.locale.extra;
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the XFCE Desktop Environment.
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = if (userSettings.desktopManager == "xfce") then true else false;

    # Configure keymap in X11
    layout = systemSettings.keyboard.layout;
    xkbVariant = systemSettings.keyboard.variant;
  };

  # Configure console keymap
  # REMARK: Should be composed from variables
  console.keyMap = systemSettings.keyboard.layout + "-latin1-" + systemSettings.keyboard.variant; #"de-latin1-nodeadkeys";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.userName} = {
    isNormalUser = true;
    description = userSettings.userName;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = systemSettings.version; # Did you read the comment?

  # Enable experimental features so that Flakes are supported
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    #x11 = true;
  } else {
    enable = false;
    #x11 = false;
  };

  users.extraGroups.vboxusers.members = if (systemSettings.installation.type == "virtual") then 
    [ "user-with-access-to-virtualbox" ]
  else [];

}
