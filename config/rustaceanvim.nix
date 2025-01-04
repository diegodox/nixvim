{ lib, config, ... }:
{
  options = {
    nixvim.rustaceanvim.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to enable rustaceanvim.
      '';
    };
  };

  config = lib.mkIf config.nixvim.rustaceanvim.enable {
    plugins.rustaceanvim.enable = config.nixvim.rustaceanvim.enable;
  };
}
