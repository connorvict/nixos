# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./audio.nix
      ./hyprland.nix
      ./locale.nix
    ];

  # nix
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };
 
  # virtualisation
  programs.virt-manager.enable = true;
  virtualisation = {
    podman.enable = true;
    libvirtd.enable = true;
  };

  # dconf
  programs.dconf.enable = true;
 
  # packages
  environment.systemPackages = with pkgs; [
    home-manager
    neovim
    git
    wget
    curl
    unzip
    less
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true;
  };

  # bootloader
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "nfts" ];
    loader = {
      timeout = 2;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  
  # fish
  programs.fish.enable = true;

  # users
  users.users.norcon = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "libvirtd"
    ];
  };

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "norcon";

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}
