{ inputs, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security = {
    polkit.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wezterm
    firefox
    waybar
    swww
    dunst
    libnotify
    rofi-wayland
    neofetch
    bat
    zoxide
    ripgrep
    fd
    procs
    eza
  ];
}
