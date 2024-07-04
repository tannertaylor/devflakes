{ pkgs ? import <nixpkgs>, ... }: let
  shellName = "dotnet dev shell";
in pkgs.mkShell {
  name = shellName;
  
  packages = [
    pkgs.dotnet-sdk
    pkgs.omnisharp-roslyn
  ];

  shellHook = ''
    echo
    echo "================================"
    echo "${shellName}"
    echo "dotnet version: $(dotnet --version)"
    echo "================================"
  '';
}
