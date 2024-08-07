{
  description = "My personal dev shell configurations.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    shellLib = import ./lib.nix { inherit pkgs; lib = pkgs.lib; };
  in {
    devShells.${system} = with shellLib; {
      rust = mkDevflakeShell {
        name = "rust";
        setup = { ... }: { tools.rust.enable = true; };
      };

      dotnet = mkDevflakeShell {
        name = "dotnet";
        setup = { ... }: { tools.dotnet.enable = true; };
      };

      dotnet6 = mkDevflakeShell {
        name = "dotnet 6";
        setup = { ... }: {
          tools.dotnet.enable = true;
          tools.dotnet.sdk.v8.enable = false;
          tools.dotnet.sdk.v6.enable = true;
        };
      };

      dotnetAzure = mkDevflakeShell {
        name = "dotnet with azure";
        setup = { ... }: {
          tools.dotnet.enable = true;
          tools.dotnet.sdk.v8.enable = false;
          tools.dotnet.sdk.v6.enable = true;
          tools.azure.enable = true;
        };
      };
    };
  };
}
