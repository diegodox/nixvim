{
  plugins.gitsigns.enable = true;

  plugins.gitsigns.settings = {
    numhl = true;
    signcolumn = false;

    current_line_blame = false;
    current_line_blame_opts = {
      delay = 100;
    };

    sign_priority = 100;

    watch_gitdir = {
      follow_files = true;
    };

    diff_opts = {
      ignore_whitespace_change = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gh";
      action = ":Gitsigns preview_hunk_inline<CR>";
    }
  ];
}
