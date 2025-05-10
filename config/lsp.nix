{
  plugins.lsp.enable = true;

  plugins.lsp.onAttach = /* lua */ ''
    -- LSP format autocommand {{{
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatting", { clear = false }),
        callback = function()
            vim.lsp.buf.format({
                bufnr = bufnr,
            })
        end,
        desc = "Format buffer just before write",
        buffer = bufnr,
    })
    vim.notify(
        "lsp formater " .. client.name .. " set to buffer " .. bufnr .. ": " .. vim.api.nvim_buf_get_name(bufnr),
        vim.log.levels.TRACE
    )
    -- }}}
  '';

  plugins.lsp.inlayHints = true;


  plugins.lsp.servers.basedpyright.enable = true;
  plugins.lsp.servers.ruff.enable = true;
  plugins.lsp.servers.lua_ls.enable = true;
  plugins.lsp.servers.clangd.enable = true;
  plugins.lsp.servers.nixd.enable = true;
}
