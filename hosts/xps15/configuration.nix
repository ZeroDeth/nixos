{ config, pkgs, credentials, ... }:

{
  imports = [
    ../_all/configuration.nix
  ];

  modules = {
    android.enable = true;
    basePackages.enable = true;
    commandNotFound.enable = true;
    desktop.enable = true;
    docker.enable = true;
    emacs.enable = true;
    fonts.enable = true;
    gnome.enable = true;
    nvidia.enable = true;
    opengl.enable = true;
    resolved.enable = true;
    virtualbox.enable = true;
    wayland.enable = true;
    x11.enable = true;
  };

  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];

  powerManagement.cpuFreqGovernor = "powersave";

  hardware.nvidia = {
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.opengl.extraPackages = [
    pkgs.intel-media-driver
    pkgs.vaapiIntel
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # systemd.additionalUpstreamSystemUnits = [ "debug-shell.service" ];

  services = {
    fstrim.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;
    smartd.enable = true;
    thermald.enable = true;
    tuptime.enable = true;
  };
}
