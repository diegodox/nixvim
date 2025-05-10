{ system, nixd, pkgs, ... }:
{
  plugins.lsp.enable = true;
  plugins.lsp.inlayHints = true;

  diagnostic.settings = {
    virtual_lines = {
      current_line = true;
    };
    virtual_text = false;
    signs = true;
  };

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
  extraPackages = [
    nixd.packages.${system}.nixd
    pkgs.alejandra
  ];

  extraConfigLua = /*lua*/''
    require("lspconfig").nixd.setup({
      settings = {
        nixd = {
          inlay_hints = true,
          formatting = {
            command = { "alejandra" },
          },
          nixpkgs = {
            expr = string.format(
              '(builtins.getFlake "%s").inputs.nixpkgs {}',
              vim.fn.getcwd() ~= "" and vim.fn.getcwd() or "/home/cdockter/myNixOS"
            ),
          },
          options = {
            nixOptions = {
              expr = string.format(
                '(builtins.getFlake "%s").nixosConfigurations.nixos.options',
                vim.fn.getcwd()
              ),
            },
            home_manager = {
              expr = string.format(
                '(builtins.getFlake "%s").homeConfigurations."cdockter".options',
                vim.fn.getcwd()
              ),
            },
            flake_parts = {
              expr = string.format(
                '(builtins.getFlake "%s").debug.options',
                vim.fn.getcwd() ~= "" and vim.fn.getcwd() or "/home/cdockter/myNixOS"
              ),
            },
            perSystem = {
              expr = string.format(
                '(builtins.getFlake "%s").currentSystem.options',
                vim.fn.getcwd() ~= "" and vim.fn.getcwd() or "/home/cdockter/myNixOS"
              ),
            },
          },
        },
      },
    })
  '';
}
