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

  plugins.noice.notify.enabled = true;
  plugins.noice.presets = { inc_rename = true; };

  plugins.noice.lsp.hover.enabled = false;
  plugins.noice.lsp.signature.enabled = false;
}
