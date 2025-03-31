{
  opts = {
    title = true;
    hidden = true;
    swapfile = false;
    encoding = "utf-8";
    fileencoding = "utf-8";
    conceallevel = 0;
    updatetime = 300;
    mouse = "a";
    clipboard = "unnamedplus";
    backspace = "indent,eol,start";
    pumblend = 7;
    pumheight = 20;
    pumwidth = 10;

    # indent settings
    smarttab = true;
    expandtab = true;
    autoindent = true;
    tabstop = 4;
    shiftwidth = 4;

    # search settings
    ignorecase = true;
    smartcase = true;

    # visual settings
    showmode = false;
    signcolumn = "yes";
    termguicolors = true;
    ruler = true;
    number = true;
    relativenumber = true;
    wrap = false;
    list = true;
    listchars = "tab:▸ ,trail:·";
    scrolloff = 5;
    sidescrolloff = 5;
    # cmdheight = 0

    # window settings
    splitbelow = true;
    splitright = true;

    foldlevel = 99;

    winborder = "rounded";
  };

  globals.mapleader = " ";
  globals.tex_flavor = "latex";
}
