{ config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.modules.basePackages;
  home-manager-package = (import inputs.home-manager { inherit pkgs; }).home-manager;
in
{
  options.modules.basePackages = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {

    programs.fish.enable = true;

    environment.systemPackages = with pkgs; [
      age
      bat
      bind
      binutils
      bridge-utils
      cifs-utils
      curl
      dmidecode
      dnsmasq
      dos2unix
      duf
      # ecryptfs
      efibootmgr
      exfat
      fd
      file
      fzf
      git
      groff
      # home-manager-package
      htop
      inetutils
      iproute2
      jq
      lm_sensors
      lzip
      mkpasswd
      most
      ncdu
      nfs-utils
      nmap
      ntfs3g
      openssl
      openvpn
      p7zip
      parted
      pciutils
      powertop
      psmisc
      pwgen
      python310Packages.cgroup-utils
      # python310Packages.wakeonlan
      rclone
      ripgrep
      rsync
      smartmontools
      strace
      # tldr
      tmux
      tree
      unrar
      unzip
      vim
      wget
      zip
      zlib
    ];
  };
}
