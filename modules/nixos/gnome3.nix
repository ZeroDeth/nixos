{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.gnome3;
in {
  options.modules.gnome3 = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      desktopManager.gnome3.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.xterm.enable = mkForce false;
    };

    services.gnome3 = {
      experimental-features.realtime-scheduling = true;
      # Disable some core OS services
      evolution-data-server.enable = mkForce false;
      gnome-online-accounts.enable = false;
      gnome-online-miners.enable = mkForce false;
      tracker.enable = false;
      tracker-miners.enable = false;
    };

    security.pam.services.gdm.enableGnomeKeyring = true;

    environment.gnome3.excludePackages = with pkgs; [
      gnome3.cheese
      gnome3.gnome-disk-utility
      gnome3.epiphany
      gnome3.geary
      gnome3.gnome-calendar
      gnome3.gnome-contacts
      gnome3.gnome-logs
      gnome3.gnome-maps
      gnome3.gnome-music
      gnome-photos
      gnome3.totem
      gnome3.yelp
    ];

    environment.systemPackages = with pkgs; [
      # Gnome utilities
      gnome3.dconf-editor
      gnome3.gnome-tweaks
      gnome3.libgnome-keyring
      # Miscellaneous applications
      chromium
      gimp
      gparted
      remmina
      vlc
      # Gnome extensions
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-panel
      gnomeExtensions.window-is-ready-remover
      (callPackage ../../pkgs/desktops/gnome-3/extensions/dynamic-panel-transparency {})
      (callPackage ../../pkgs/desktops/gnome-3/extensions/just-perfection {})
      (callPackage ../../pkgs/desktops/gnome-3/extensions/shortcuts {})
      (callPackage ../../pkgs/desktops/gnome-3/extensions/switcher {})
      # Ubuntu look & feel
      yaru-theme
    ];

    # Fonts
    fonts.fonts = with pkgs; [
      cantarell-fonts
      dejavu_fonts
      fira-code
      fira-code-symbols
      inconsolata
      # google-fonts
      # mplus-outline-fonts
      # noto-fonts
      roboto
      roboto-mono
      source-code-pro
      source-sans-pro
      ubuntu_font_family
    ];
  };
}
