{
  plugins.lualine.enable = true;

  # enable deps
  plugins.web-devicons.enable = true;
  plugins.treesitter.enable = true;

  plugins.lualine.settings.options = {
    globalstatus = true;
    refresh.statusline = 300;
    refresh.winbar = 300;

    section_separators = { left = ""; right = ""; };
    disabled_filetypes.winbar = [
      "toggleterm"
      "Trouble"
      "dapui_scopes"
      "dapui_breakpoints"
      "dapui_watchs"
      "dapui_repl"
      "dapui_console"
    ];
  };

  plugins.lualine.luaConfig.pre = ''
  function replace_empty(relpaced)
    return function(str)
      if str == "" then
        return replaced
      else
        return str
      end
    end
  end

  function hide(win_width)
    return function()
      local ui = vim.api.nvim_list_uis()
      if not ui or ui[1] or not ui[1]["width"] then
        return true
      end
      return ui[1]["width"] > win_width
    end
  end

  modules = {
    icon = {
      "filetype",
      icon_only = true,
      colors = false,
      separator = "",
      padding = { right = 0, left = 1 },
      fmt = function(str)
        local icon = require("nvim-web-devicons")
        if not icon.get_icon(vim.fn.expand("%:t"), vim.bo.filetype) then
          return nil
        end
        return str
      end
    },
    filename = function(cfg)
      return vim.tbl_extend("keep", cfg or {}, {
        "filename",
        symbols = {
          modified = " +",
          readonly = " ",
        },
      })
    end,
    center = {
      "%=",
      separator = "",
      padding = { right = 0, left = 0 },
    },
    cwd = {
      "vim.fn.getcwd()",
      fmt = function(cwd)
        return require().path_icon(cwd)
      end
    },
  }
  '';

  plugins.lualine.settings.sections = let
    branch = { __raw = "{ \"branch\", fmt = replace_empty(\"-\")}"; };
    icon = { __raw = ''modules.icon''; };
    filename = { __raw = ''modules.filename()''; };
    center= { __raw = ''modules.center''; };
    # cwd = { __raw = ''modules.cwd''; };
  in {
    lualine_a = [ "mode" branch ];
    lualine_b = [ icon filename ]; # noice_module.recording
    lualine_c = [ center ]; # mod.center mod.signature_label
    lualine_x = [
      # mod.search
      {
        __unkeyed-1 = "diff";
        source = {
          __raw = "vim.b.gitsigns_head";
        };
      }
    ];
    lualine_y = [
      {
        __unkeyed-1 = "location";
        cond = {
          __raw = "hide(200)";
        };
      }
    ];
    # lualine_z = [ cwd ];
  };
}