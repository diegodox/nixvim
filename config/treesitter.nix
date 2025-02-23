{ pkgs, lib, config, ... }:{
  options = {
    nixvim.treesitter.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to enable treesitter.
      '';
    };

    nixvim.treesitter.folding = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to enable treesitter folding.
      '';
    };

    # nixvim.treesitter.indent = lib.mkOption {
    #   # bool or list of raw lua
    #   type = lib.types.either lib.types.bool (lib.types.listOf (lib.types.maybeRaw lib.types.str));
    #   default = true;
    #   description = ''
    #     Whether to enable treesitter folding.
    #   '';
    # };
  };

  config = lib.mkIf config.nixvim.treesitter.enable {
    plugins.treesitter.enable = true;

    plugins.treesitter.folding = true;
    plugins.treesitter.settings.folding = config.nixvim.treesitter.folding;
    plugins.treesitter.settings.indent.enable = config.nixvim.treesitter.folding;
    plugins.treesitter.settings.highlight.enable = true;

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      lua
      scheme
    ];

    plugins.treesitter.nixvimInjections = false;

    extraFiles."queries/markdown/injections.scm" = let
    markdown-injection = /* scheme */ ''
    (fenced_code_block
      (info_string) @injection.language
      (code_fence_content) @injection.content
    )
    '';
    in { text = markdown-injection; };
  };
}
