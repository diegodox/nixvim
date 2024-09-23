{pkgs, ...}: {
  # run neovim nightly
  package = pkgs.neovim;

  # Import all your configuration modules here
  imports = [ ./bufferline.nix ];
}
