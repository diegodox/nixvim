{ lib, config, ...}:
{
  options = {
    nixvim.statuscol.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Is enable statuscol plugin
      '';
    };
  };

  config = lib.mkIf config.nixvim.statuscol.enable {
    plugins.statuscol.enable = true;
  };

}
