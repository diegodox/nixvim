{
  plugins.telescope.enable = true;

  plugins.telescope.extensions.frecency.enable = true;

  plugins.telescope.luaConfig.pre = ''
    local actions = require("telescope.actions")

    --- dynamic layout based on nvim window size
    ---@param threshold number
    ---@return string
    function dynamic_layout_strategy(threshold)
        local ui = vim.api.nvim_list_uis()
        if not ui or not ui[1] or not ui[1]["width"] then
            return "vertical"
        end
        if ui[1]["width"] > threshold then
            return "horizontal"
        end
        return "vertical"
    end

    --- Call `git_files` if in git directory, otherwise call `find_files`.
    --- Smarter than my old config.
    function smart_find_file()
        local builtin = require("telescope.builtin")
        local threshold = 170
        vim.fn.system("git rev-parse")
        if vim.v.shell_error == 0 then
            builtin.git_files({
                layout_strategy = dynamic_layout_strategy(threshold),
                show_untracked = true,
            })
        else
            local telescope = package.loaded.telescope
            telescope.extensions.frecency.frecency({
                layout_strategy = dynamic_layout_strategy(threshold),
            })
        end
    end
  '';

  plugins.telescope.settings.defaults = {
    vimgrep_arguments = [
      "rg"
      "--color=never"
      "--no-heading"
      "--with-filename"
      "--line-number"
      "--column"
      "--smart-case"
    ];
    layout_strategy = "horizontal";
    layout_defaults = {
      horizontal = {
        mirror = true;
        preview_width = 0.7;
      };
      vertical = {
        mirror = true;
      };
    };
    mappings = {
      i = {
        "<C-h>" = "which_key";
        "<esc>" = { __raw = "actions.close"; };
      };
    };
    winblend = 7;
  };

  plugins.telescope.settings.pickers = {
    find_files = {
      prompt_prefix = "🔍";
    };
    git_files = {
      prompt_prefix = "🔍";
    };
    buffers = {
      mappings = {
        i = {
          "<C-z>" = "delete_buffer";
        };
      };
    };
  };

  # keymaps
  keymaps = [{
    mode = "n";
    key = "<C-p>";
    action.__raw = "smart_find_file";
    options.desc = "Telescope smart find file";
  }];

  # telescope keymaps
  # # Example
  # "<C-p>" = {
  #   action = "git_files"; <- map to "<Cmd>Telescope $actionstr<cr>"
  #   options = {
  #     desc = "Telescope Git Files";
  #   };
  # };
  # "<leader>fg" = "live_grep"; <- map to "<Cmd>Telescope $actionstr<cr>"
  plugins.telescope.keymaps = {
    "<Leader>tb" = {
      action = "buffers";
      options = {
        desc = "List buffers";
      };
    };
    "<Leader>tB" = {
      action = "builtin";
      options = {
        desc = "Find builtin features";
      };
    };
    "<Leader>tf" = {
      action = "find_files";
      options = {
        desc = "Find file";
      };
    };
    "<Leader>tg" = {
      action = "live_grep";
      options = {
        desc = "Live grep";
      };
    };
    "<Leader>tr" = {
      action = "oldfiles";
      options = {
        desc = "MRU";
      };
    };
    "<Leader>tk" = {
      action = "keymaps";
      options = {
        desc = "List keymaps";
      };
    };
    "<Leader>tG" = {
      action = "git_files";
      options = {
        desc = "Git files";
      };
    };
    "<Leader>th" = {
      action = "help_tags";
      options = {
        desc = "List Helps";
      };
    };
    "<Leader>tH" = {
      action = "highlights";
      options = {
        desc = "List Highlights";
      };
    };
  };

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<Leader>t";
      group = "Telescope";
    }
  ];
}
