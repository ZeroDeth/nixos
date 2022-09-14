{ config, lib, pkgs, inputs, vars, credentials, ... }:

{
  imports = [
    ../_all/configuration.nix
  ];

  modules = {
    nix.enable = lib.mkForce false;
  };

  boot.isContainer = true;
  boot.specialFileSystems = lib.mkForce {};

  networking = {
    hostName = "";
    nameservers = [ "8.8.8.8" ];
    firewall.enable = lib.mkForce false;
  };

  systemd.services.console-getty.enable = false;
  # systemd.services.systemd-logind.enable = false;
  # systemd.services.nix-daemon.enable = false;
  # systemd.sockets.nix-daemon.enable = false;

  services.journald.console = "/dev/console";

  documentation = {
    enable = lib.mkForce false;
    nixos.enable = lib.mkForce false;
  };
  programs.command-not-found.enable = false;

  users.allowNoPasswordLogin = true;
}
