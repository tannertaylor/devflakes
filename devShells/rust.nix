{ pkgs ? import <nixpkgs>, ... }: let
  shellName = "Rust Dev Shell";
in pkgs.mkShell {
  name = shellName;

  packages = [
    pkgs.rustc
    pkgs.cargo
    pkgs.rust-analyzer
  ];

  shellHook = ''
    echo
    echo "================================"
    echo "${shellName}"
    echo "Rust Version: $(rustc --version)"
    echo "================================"
  '';
}
