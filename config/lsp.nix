{ system, nixd, ... }:
{
  plugins.lsp.enable = true;
  plugins.lsp.inlayHints = true;

  plugins.lsp.servers.basedpyright.enable = true;
  plugins.lsp.servers.ruff.enable = true;
  plugins.lsp.servers.lua_ls.enable = true;
  plugins.lsp.servers.clangd.enable = true;
  plugins.lsp.servers.nixd = {
    enable = true;
    package = nixd;
  };
  extraPackages = [
    nixd.packages.${system}.nixd
  ];
}
