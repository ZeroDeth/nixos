{ stdenv, pkgs, config-name, ... }:

let
  script = pkgs.writeShellScriptBin "nixos-option" ''
    env "CONFIG_NAME=${config-name}" ${pkgs.nixos-option}/bin/nixos-option -I nixpkgs=${./compat} $@
  '';
in stdenv.mkDerivation rec {
  name = "nixos-option";
  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/bin
    ln -s ${script}/bin/nixos-option $out/bin/
  '';
}
