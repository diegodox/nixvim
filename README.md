# Nixvim template

This template gives you a good starting point for configuring nixvim standalone.

## Configuring

To start configuring, just add or modify the nix files in `./config`.
If you add a new configuration file, remember to add it to the
[`config/default.nix`](./config/default.nix) file

## Testing your new configuration

To test your configuration simply run the following command

Run nvim
```nix
# run stable nvim
nix run .#stable
# run nightly nvim
nix run .#nightly
```

Develop shell with nix/lua lsp and nvim
```nix
nix develop .#devStable
nix develop .#devNightly
```
