{ lib, config, ... }:
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

  config = lib.mkIf config.nixvim.lazygit.enable {
    plugins.lazygit.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<C-g>";
        action = ":LazyGit<CR>";
      }
    ];
  };
}
