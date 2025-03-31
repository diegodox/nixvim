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

  plugins.noice.luaConfig.pre = /* lua */ ''
  -- Set up noice {{
  do
    -- workaround for nvim0.11 winborder
    local initialWinborder = vim.o.winborder
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      callback = function() vim.o.winborder = "none" end,
    })
    vim.api.nvim_create_autocmd("CmdlineLeave", {
      callback = function() vim.o.winborder = initialWinborder end,
    })
  end
  '';

}
