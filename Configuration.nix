# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "Kiosk-YOURPREFEREDNAME"; # Define your hostname.
  # networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  networking.proxy.default = "http://FooBar:Proxy";
  networking.proxy.noProxy = "127.0.0.1,localhost";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone!
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties!
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  console = {
    earlySetup = true;
    useXkbConfig = true;
  };
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
  };

  systemd.services."cage-tty1".after = [
    "network-online.target"
    "systemd-resolved.service"
  ];

  programs.chromium = {
    enable = true;
	package = pkgs.chromium;
	
	extraOpts = {
	   "BrowserSignin" = 0;
       "SyncDisabled" = true;
       "PasswordManagerEnabled" = false;
       "SpellcheckEnabled" = false;
	};
  };

  systemd.services.cage-tty1.environment.XKB_DEFAULT_LAYOUT = "de";

  services.cage = {
    enable = true;
    user = "kiosk";
#    program = "${pkgs.chromium}/bin/chromium https://FOOBAR.COM/ --kiosk --lang=de --enable-extensions --noerrdialogs --no-first-run";
    program = "${pkgs.chromium}/bin/chromium --lang=de --noerrdialogs --no-first-run";
  };

  systemd.services.cage-tty1.environment

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kiosk = {
    isNormalUser = true;
    description = "FOOBAR";
    extraGroups = [ "networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    pkgs.chromium
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 80,443 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
	NIXOS_OZONE_WL = "1";
  };

}
