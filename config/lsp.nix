{ system, nixd, pkgs, ... }:
{
  plugins.lsp.enable = true;
  plugins.lsp.inlayHints = true;

  plugins.lsp.onAttach = /* lua */''
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  '';
  plugins.lsp.servers.basedpyright.enable = true;
  plugins.lsp.servers.ruff.enable = true;
  plugins.lsp.servers.lua_ls.enable = true;
  plugins.lsp.servers.clangd.enable = true;
  plugins.lsp.servers.nixd = {
    enable = true;
    package = nixd;
    settings = {
      formatting.command = [ "alejandra" ];
  };
  extraPackages = [
    nixd.packages.${system}.nixd
    pkgs.alejandra
  ];
}
