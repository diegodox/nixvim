{ lib, ... }:
let
  # Move visual line
  move-in-visualline = (map (k: {
    mode = "n";
    key = k;
    action = "g"+k;
    options.desc = "Move visual line";
  }) ["j" "k"]);

  # keep select while indentation
  continuous-indent = (map (k: {
    mode = "v";
    key = k;
    action = k +"gv";
    options.desc = "Keep select while indenting";
  }) [ "<" ">"]);

  # No arrow keys
  no-arrow-keys = (map (k: {
    mode = "n";
    key = k;
    action = "<nop>";
    options.desc = "No arrowkeys, use hjkl";
  }) ["<up>" "<down>" "<left>" "<right>"]);

  # scroll
  half-scroll = (map (k: {
    mode = "n";
    key = k;
    action = k+"zz";
  }) ["<C-d>" "<C-u>"]);

  # easy save
  easy-save = {
    mode = "n";
    key = "<C-s>";
    action.__raw = "function() vim.cmd(\"update\") end";
    options.desc = "Previous Error";
  };

  # jump between errors
  jump-errors = [
    {
      mode = "n";
      key = "[e";
      action.__raw = "function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR }) end";
      options.desc = "Previous Error";
    }
    {
      mode = "n";
      key = "]e";
      action.__raw = "function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR }) end";
      options.desc = "Next Error";
    }
  ];

  # jump between diagnostics
  jump-diagnotic = [
    {
      mode = "n";
      key = "[w";
      action.__raw = "vim.diagnostic.goto_prev";
      options.desc = "Previous Diagnostic";
    }
    {
      mode = "n";
      key = "]w";
      action.__raw = "vim.diagnostic.goto_next";
      options.desc = "Next Diagnostic";
    }
  ];

  resize = let
    resizeKeys = [ "+" "-" ">" "<" ];
  in
    # Loop over the resize keys for <C-w> mappings
    (map (k: {
      mode = "n";
      key = "<C-w>" + k;
      action = "<C-w>" + k + "<Plug>(resize)";
      options.silent = true;
      options.remap = true;
    }) resizeKeys)

    # Loop over the resize keys for <Plug>(resize) mappings
    ++ (map (k: {
      mode = "n";
      key = "<Plug>(resize)" + k;
      action = "<C-w>" + k + "<Plug>(resize)";
      options.silent = true;
    }) resizeKeys)

    # Mapping <Plug>(resize) to <Nop>
    ++ [{
      mode = "n";
      key = "<Plug>(resize)";
      action = "<Nop>";
      options.silent = true;
      options.remap = true;
    }];

  func = let
    before = [ "F1" "F2" "F3" "F4" "F5" "F6" "F7" "F8" "F9" "F10" ];
    after = [ "q" "w" "e" "r" "t" "y" "u" "i" "o" "p" ];
  in
    map (pair: {
      mode = "c";
      key = "<" + pair.fst + ">";
      action = pair.snd;
    }) (lib.lists.zipLists before after);
in
{
  keymaps = move-in-visualline
  ++ continuous-indent
  ++ no-arrow-keys
  ++ half-scroll
  ++ jump-errors
  ++ jump-diagnotic
  ++ [ easy-save ]
  ++ resize
  ++ func;
}
