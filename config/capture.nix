{pkgs, plugin-capture, ... }: let
  plugin = pkgs.vimUtils.buildVimPlugin {
    name = "capture";
    src = plugin-capture;
  };
in
{
  extraPlugins = [ plugin ];
}
