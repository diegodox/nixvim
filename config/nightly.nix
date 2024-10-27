{ pkgs, lib, config, ... }:
{
  options = {
     nixvim.nightly.enable = lib.mkOption {
       type = lib.types.bool;
       default = true;
       description = ''
         Is use nightly neovim, set false for stable.
       '';
     };
  };

  config = lib.mkIf config.nixvim.nightly.enable {
    # run neovim nightly
    package = pkgs.neovim;
  };
}
