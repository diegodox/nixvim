{
  plugins.noice.enable = true;

  # plugins.noice.routes = {
  #   filter = [
  #     {
  #       event = "msg_show";
  #       kind = "search_count";
  #     }
  #     opts = { skip = true; }
  #   ];
  # };

  plugins.noice.settings.notify.enabled = true;
  plugins.noice.settings.presets = { inc_rename = true; };

  plugins.noice.settings.lsp.hover.enabled = false;
  plugins.noice.settings.lsp.signature.enabled = false;
}
