{ config, pkgs, lib, ... }: with lib; {
  options = with options; {
    tools.dotnet = {
      enable = mkEnableOption ".NET Tools";
      sdk = {
        v8.enable = mkOption {
          description = "Whether to enable .NET 8 SDK";
          default = true;
          type = lib.types.bool;
        };
        v7.enable = mkEnableOption ".NET 7 SDK";
        v6.enable = mkEnableOption ".Net 6 SDK";
      };
    };
  };

  config = let
    dotnetConfig = config.tools.dotnet;
  in mkIf dotnetConfig.enable {
    packages = with pkgs; let
      sdks = symlinkJoin { # TODO: Despite symlinking, it looks like dotnet still can't see .NET 6 if .NET 8 is also installed.
        name = "dotnet";
        paths = with lists; []
          ++ optional dotnetConfig.sdk.v8.enable dotnet-sdk_8
          ++ optional dotnetConfig.sdk.v7.enable dotnet-sdk_7
          ++ optional dotnetConfig.sdk.v6.enable dotnet-sdk;
      };
    in [
      sdks
      omnisharp-roslyn
    ];

    shellHeaders = [
      "dotnet version: $(dotnet --version)"
    ];
  };
}

