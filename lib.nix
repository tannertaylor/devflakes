{ pkgs, lib, ... }: {
  mkDevflakeShell = { name, packages ? [], modules ? [], setup ? { ... }: { } }: let
    config = (lib.evalModules {
      modules = [
        ({ config, ... }: { config._module.args = { inherit pkgs; }; })
        ./options.nix
        ./modules/rust.nix
        ./modules/dotnet.nix
        ./modules/azure.nix
      ] ++ modules ++ [ setup ];
    }).config;

    echoedShellHeaders = lib.concatStringsSep "\n" (map (x: "echo \"${x}\"") config.shellHeaders);
  in pkgs.mkShell {
    name = name;
    packages = packages ++ config.packages;
    shellHook = ''
      echo
      echo "==========================="
      echo "Nix Shell: ${name}"
      ${echoedShellHeaders}
      echo "==========================="
    '';
  };
}
