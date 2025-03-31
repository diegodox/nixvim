{ config, ... }:
let
  enabled = config.nixvim.completion.plugin == "blink";
in
{
  config = {
    plugins.blink-cmp.enable = enabled;
    plugins.blink-cmp.settings.keymap.preset = "super-tab";
  };
}
