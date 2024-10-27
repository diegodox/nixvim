{ pkgs, plugin-hlchunk, lib, config, ... }: let
  plugin = pkgs.vimUtils.buildVimPlugin {
    name = "hlchunk";
    src = plugin-hlchunk;
  };
in
{
  options = {
    nixvim.hlchunk.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Is enable hlchunk plugin
      '';
    };
  };

  config = lib.mkIf config.nixvim.hlchunk.enable {
    extraPlugins = [ plugin ];
    extraConfigLua = ''
    -- Set up hlchunk {{
    do
      require('hlchunk').setup({
        chunk = { enable = true },
        indent = { enable = true, chars = { "┊" } }
      })
    end
    -- }}
    '';
  };
}

