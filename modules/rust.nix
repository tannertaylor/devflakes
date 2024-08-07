{ config, pkgs, lib, ... }:
with lib;
let
  rustConfig = config.tools.rust;
in {
  options = with options; {
    tools.rust = {
      enable = mkEnableOption "Rust Tools";
    };
  };

  config = mkIf rustConfig.enable {
    packages = [
      pkgs.rustc
      pkgs.cargo
      pkgs.rust-analyzer
      pkgs.rustfmt
    ];

    shellHeaders = [
      "Rust Version: $(rustc --version)"
    ];
  };
}
