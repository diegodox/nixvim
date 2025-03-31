# nixvimConfigSearch: https://nix-community.github.io/nixvim/search
{ nightly ? false, ...}:
{
  # Import all your configuration modules here
  imports = [./nightly.nix ] ++ [
    ./settings.nix
    ./keymap.nix
  ] ++ [
    ./lsp.nix
    ./lualine.nix
    ./tokyonight.nix
    ./gitsigns.nix
    ./noice.nix
    ./telescope.nix
    ./whichkey.nix
    ./fcitx5nvim.nix
    ./capture.nix
    ./hlchunk.nix
    ./treesitter.nix
    ./rustaceanvim.nix
    ./snacks.nix
    ./completion
  ];

  plugins.colorizer.enable = true;
  plugins.inc-rename.enable = true;
  plugins.undotree.enable = true;
  plugins.markdown-preview.enable = true;
  plugins.sandwich.enable = true;
  plugins.trouble.enable = true;
  plugins.nvim-ufo.enable = true;
  plugins.guess-indent.enable = true;
  plugins.glance.enable = true;

  nixvim.nightly.enable = nightly;

  wrapRc = true;

  clipboard = { register = "unnamedplus"; };
}
