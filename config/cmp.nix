{
  plugins.cmp.enable = true;

  plugins.cmp.luaConfig.pre = /* lua */ ''
  -- Set up cmp {{
  do
    local luasnip = require('luasnip')
  '';

  plugins.cmp.luaConfig.post = /* lua */ ''
  end
  -- }}
  '';

  # sources
  plugins.cmp-path.enable = true;
  plugins.cmp-buffer.enable = true;
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-cmdline.enable = true;
  plugins.cmp.autoEnableSources = true;
  plugins.cmp.settings.sources = [
    { name = "nvim_lua"; priority = 1000; }
    { name = "nvim_lsp"; priority = 800; }
    { name = "luasnip"; priority = 500; }
    { name = "path"; priority = 300; }
    { name = "buffer"; priority = 200; }
  ];

  # snippet
  plugins.luasnip.enable = true;
  plugins.cmp_luasnip.enable = true;
  plugins.cmp.settings.snippet.expand = /* lua */ ''
    function(args)
      luasnip.lsp_expand(args.body)
    end
  '';

  # kind
  plugins.lspkind.enable = true;
  plugins.lspkind.cmp.enable = true;
  plugins.lspkind.cmp.maxWidth = 50;
  plugins.lspkind.mode = "symbol";
  plugins.lspkind.cmp.menu = {
    "buffer" = "[buf]";
    "nvim_lsp" = "[LSP]";
    "nvim_lua" = "[api]";
    "path" = "[path]";
    "luasnip" = "[snip]";
    "cmdline" = "[cmd]";
  };
  plugins.cmp.settings.formatting.fields = [ "kind" "abbr" "menu" ];

  # mapping
  plugins.cmp.settings.mapping = /* lua */ {
    "<C-Up>" = /* lua */ "cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'})";
    "<C-Down>" = /* lua */ "cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'})";

    "<Up>" = /* lua */ ''
    cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {'i', 'c'})
    '';
    "<Down>" = /* lua */ ''
    cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {'i', 'c'})
    '';

    "<C-Space>" = /* lua */ "cmp.mapping.complete()";
    "<C-e>" = /* lua */ "cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() })";

    "<CR>" = /* lua */ "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })";

    "<Tab>" = /* lua */ ''
    cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = false })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' })
    '';
  };

  plugins.cmp.cmdline= {
    ":" = {
      mapping = {
        "<Tab>" = /* lua */ ''
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = false })
          else
            fallback()
          end
        end, { "c" })
        '';
      };

      sources = [
        { name = "path"; }
        { name = "cmdline"; }
      ];
    };
  };

  # plugins.cmp.settings.experimental = { ghost_text = true; };
}
