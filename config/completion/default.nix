{ lib, ... }:
{
  options = {
    nixvim.completion.plugin = lib.mkOption {
      type = lib.types.null or lib.types.enum ["cmp" "blink"];
      default = "blink";
      description = ''
        which completion plugin to enable
      '';
    };
  };


  imports = [
    ./blink.nix
    ./cmp.nix
  ];
}
