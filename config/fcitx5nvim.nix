{ pkgs, lib, config, plugin-fcitx5nvim, ...}: let
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "fcitx5";
      src = plugin-fcitx5nvim;
    };
in
{
  options = {
    nixvim.fcitx5.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether enable fcitx5.nvim
      '';
    };
  };

  config = let
    config_str = /* lua */ ''
      -- Set up fcitx5.nvim {{
      require("fcitx5").setup({
        ime_on_status = "2",
        ime_off_status = "1",
        ime_on_arg = "-o",
        ime_off_arg = "-c",
      })
      -- }}
    '';
  in lib.mkIf config.nixvim.fcitx5.enable {
    extraPlugins = [ plugin ];
    extraConfigLua = config_str;
  };
}

