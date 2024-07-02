{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = pkgs.lib;
    args = { inherit pkgs; inherit lib; };
  in {
    devShells.${system} = {
      rust = import devShells/rust.nix args;
    };
  };
}
