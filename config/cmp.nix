{
  plugins.cmp.enable = true;

  plugins.cmp.luaConfig.pre = ''
  -- Set up cmp {{
  do
    local luasnip = require('luasnip')
  '';

  plugins.cmp.luaConfig.post = ''
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
  plugins.cmp.settings.snippet.expand = ''
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
  plugins.cmp.settings.mapping = {
    "<C-Up>" = "cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'})";
    "<C-Down>" = "cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'})";

    "<Up>" = ''cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {'i', 'c'})
    '';
    "<Down>" = ''
    cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {'i', 'c'})
    '';

    "<C-Space>" = "cmp.mapping.complete()";
    "<C-e>" = "cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() })";

    "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })";

    "<Tab>" = ''cmp.mapping(function(fallback)
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
        "<Tab>" = /* lua */ ''cmp.mapping(function(fallback)
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
