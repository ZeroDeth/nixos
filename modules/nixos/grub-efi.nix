{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.grubEfi;
in
{
  options.modules.grubEfi = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
      grub = {
        device = "nodev";
        efiSupport = true;
      };
      timeout = 3;
    };
  };
}
