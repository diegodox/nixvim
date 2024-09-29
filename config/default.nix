# nixvimConfigSearch: https://nix-community.github.io/nixvim/search
{nightly ? false, ...}:
let
  nightly_module = if nightly then [ ./nightly.nix ] else [];
in
{
  # Import all your configuration modules here
  imports = [
    ./settings.nix
    ./keymap.nix
  ] ++ [
    ./lsp.nix
    ./cmp.nix
    ./lualine.nix
    ./tokyonight.nix
    ./gitsigns.nix
    ./noice.nix
    ./telescope.nix
    ./whichkey.nix
    ./fcitx5nvim.nix
    ./capture.nix
  ] ++ nightly_module;

  plugins.nvim-colorizer.enable = true;
  plugins.inc-rename.enable = true;
  plugins.undotree.enable = true;
  plugins.markdown-preview.enable = true;
  plugins.sandwich.enable = true;

  wrapRc = true;
}
