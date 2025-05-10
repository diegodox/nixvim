{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixvim.url = "github:nix-community/nixvim";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    nixd = {
      url = "github:nix-community/nixd";
      inputs.flake-parts.follows = "flake-parts";
    };

    plugin-fcitx5nvim = {
      url = "github:diegodox/fcitx5.nvim";
      flake = false;
    };
    plugin-capture = {
      url = "github:tyru/capture.vim";
      flake = false;
    };
    plugin-hlchunk = {
      url = "github:shellRaining/hlchunk.nvim";
      flake = false;
    };

  };

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    allow-import-from-derivation = true;
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
          };

          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              nightly = false;
              inherit system;
              inherit (inputs) nixd plugin-capture plugin-fcitx5nvim plugin-hlchunk;
            };
          };

          nvimNightly = nixvim'.makeNixvimWithModule (pkgs.lib.recursiveUpdate nixvimModule { extraSpecialArgs.nightly = true; });
          nvimStable = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          devShells = {
            devNightly = pkgs.mkShell {
              packages = [ pkgs.nil nvimNightly];
              shellHook = ''
                # Will open init.lua in nvim
                function viewInitLua () {
                  nvim --startuptime /tmp/nvim_start -c exit
                  cat /tmp/nvim_start | grep init.lua | grep sourcing | awk '{print $5}' | xargs nvim
                  rm /tmp/nvim_start
                }
              '';
            };
            devStable = pkgs.mkShell {
              packages = [ pkgs.nil pkgs.hello nvimStable];
            };
          };

          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            nightly = nvimNightly;
            stable = nvimStable;

            # Lets you run `nix run .` to start nixvim
            default = nvimStable;
          };
        };
    };
}
