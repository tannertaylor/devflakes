{ lib, ... }: 
with lib.options;
with lib.types;
{
  options = {
    packages = mkOption {
      type = listOf package;
      default = [];
    };

    shellHeaders = mkOption {
      type = listOf str;
      default = [];
    };
  };
}
