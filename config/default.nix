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
    ./whichkey.nix
  ] ++ nightly_module;

  wrapRc = true;
}
