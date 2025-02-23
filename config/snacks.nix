{ config, lib, ... }:
{
  options = {
    nixvim.lazygit.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Is enable lazygit plugin
      '';
    };
  };

  config = {
    plugins.snacks.enable = true;
    plugins.snacks.settings.lazygit = {
      enable = config.nixvim.lazygit.enable;
    };
    keymaps = [
      (lib.mkIf config.nixvim.lazygit.enable {
        mode = "n";
        key = "<C-g>";
        action.__raw = /*lua*/ "require('snacks').lazygit.open";
      })
    ];
  };
}
