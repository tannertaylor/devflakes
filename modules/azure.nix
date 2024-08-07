{ config, pkgs, lib, ... }: with lib; {
  options = {
    tools.azure = {
      enable = mkEnableOption "Azure Tools";
    };
  };

  config = let
    azureConfig = config.tools.azure;
  in mkIf azureConfig.enable {
    packages = with pkgs; [
      azure-functions-core-tools
    ];

    shellHeaders = [
      "azure func version: $(func -v)"
    ];
  };
}
