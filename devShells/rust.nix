{ pkgs ? import <nixpkgs>, ... }: let
  shellName = "Rust Dev Shell";
in pkgs.mkShell {
  name = shellName;

  packages = [
    pkgs.rustc
    pkgs.cargo
    pkgs.rust-analyzer
    pkgs.rustfmt
  ];

  shellHook = ''
    echo
    echo "================================"
    echo "${shellName}"
    echo "Rust Version: $(rustc --version)"
    echo "================================"
  '';
}
