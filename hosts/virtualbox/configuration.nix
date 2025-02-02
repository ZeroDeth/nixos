{ config, pkgs, inputs, vars, credentials, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../_all/configuration.nix
  ];

  modules = {
    basePackages.enable = true;
    btrfs.enable = true;
    commandNotFound.enable = true;
    emacs.enable = true;
    resolved.enable = true;
    sshd.enable = true;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "virtualbox";
    dhcpcd.enable = false;
  };

  systemd.network = {
    enable = true;
    networks = {
      "01-nat" = {
        matchConfig = {
          Name = "enp0s3";
        };
        DHCP = "yes";
        dns = [ "8.8.8.8" ];
      };
      "02-host-only" = {
        matchConfig = {
          Name = "enp0s8";
        };
        address = [
          "192.168.56.101/24"
        ];
      };
    };
  };

  swapDevices = [{ device = "/.swapfile"; }];

  virtualisation.virtualbox.guest = {
    enable = true;
    x11 = true;
  };

  users = {
    groups.markus.gid = 1000;
    users = {
      markus = {
        uid = 1000;
        description = "Markus";
        isNormalUser = true;
        group = "markus";
        extraGroups = [ "wheel" ];
        password = credentials.markus.password;
        shell = pkgs.fish;
      };
    };
  };

  home-manager.users.markus = ../../users/markus/home.nix;
}
