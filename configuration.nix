# DESCRIPTION: Main System Configuration File
{ inputs, config, pkgs, systemSettings, userSettings, ... }:

{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];


  # DESCRIPTION: Bootloader.
  boot.loader.grub = {
    enable = true;
    device = systemSettings.installation.bootloader.device;
    useOSProber = true;
  };

  networking = {
    hostName = systemSettings.hostName; # DESCRIPTION: Define hostname.
    # wireless.enable = true;  # DESCRIPTION: Enables wireless support via wpa_supplicant.

    # DESCRIPTION: Enable networking
    networkmanager.enable = true;
  };

  # DESCRIPTION: Set your time zone.
  time.timeZone = systemSettings.timeZone;

  # DESCRIPTION: Select internationalisation properties.
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
    # DESCRIPTION: Enable the X11 windowing system.
    enable = true;

    # DESCRIPTION: Enable the XFCE Desktop Environment.
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = if (userSettings.desktopManager == "xfce") then true else false;

    # DESCRIPTION: Configure keymap in X11
    # Before 24.05:
    # layout = systemSettings.keyboard.layout;
    # xkbVariant = systemSettings.keyboard.variant;
    # Since 24.05: 
    xkb = {
      layout = systemSettings.keyboard.layout; 
      variant = systemSettings.keyboard.variant;
    };
  };

  # DESCRIPTION: Configure console keymap
  # REMARK: Should be composed from variables
  console.keyMap = systemSettings.keyboard.layout + "-latin1-" + systemSettings.keyboard.variant; #"de-latin1-nodeadkeys";

  # DESCRIPTION: Enable CUPS to print documents.
  services.printing.enable = true;

  # DESCRIPTION: Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # DESCRIPTION: Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Scanner Support
  hardware.sane.enable = true; # enables support for SANE scanners

  # DESCRIPTION: Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.userName} = {
    isNormalUser = true;
    description = userSettings.userName;
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ]; # REMARK: "scanner" "lp" required for Scanner Support
  };

  # DESCRIPTION: Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true); # REMARK: Required so that home manager will install unfree packages
    };
  };

  # DESCRIPTION: List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    evince
    epsonscan2
    zip
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = systemSettings.version; # Did you read the comment?

  # DESCRIPTION: Enable experimental features so that Flakes are supported
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
