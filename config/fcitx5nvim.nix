{pkgs, plugin-fcitx5nvim, ...}: let
  plugin = pkgs.vimUtils.buildVimPlugin {
    name = "fcitx5";
    src = plugin-fcitx5nvim;
  };
  config = /* lua */ ''
  require("fcitx5").setup({
    ime_on_status = "2",
    ime_off_status = "1",
    ime_on_arg = "-o",
    ime_off_arg = "-c",
  })
  '';
in
{
  extraPlugins = [ plugin ];
  extraConfigLua = config;
}
