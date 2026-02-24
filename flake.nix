{
  description = "My home manager configuration";

  inputs = { 
    nixpkgs.url = "nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-25.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations = {
        "mau" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ({
              home.username = "mau";
              home.homeDirectory = "/home/mau";
            })
            ./home.nix 
            ./share/zsh.nix    # config console
            ./share/tmux.nix   # config tmux
            #./share/tmuxp.nix  # config setup of tmux env
            ./share/neovim/neovim.nix
            ./share/neovim/plugins.nix
            ./share/neovim/keymaps.nix
            ./share/neovim/autoCMD.nix
            ./share/firefox.nix
            nixvim.homeManagerModules.nixvim
          ];
        };
        "maurin.audenard" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ({
              home.username = "maurin.audenard";
              home.homeDirectory = "/home/maurin.audenard";
            })
            ./home.nix 
            ./share/zsh.nix    # config console
            ./share/tmux.nix   # config tmux
            ./share/neovim/neovim.nix
            ./share/neovim/plugins.nix
            ./share/neovim/keymaps.nix
            ./share/neovim/autoCMD.nix
            nixvim.homeManagerModules.nixvim
          ];
        };
        "julie.viossat" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ({
              home.username = "julie.viossat";
              home.homeDirectory = "/home/julie.viossat";
            })
            ./home.nix 
            ./share/zsh.nix    # config console
            ./share/tmux.nix   # config tmux
            ./share/neovim/neovim.nix
            ./share/neovim/plugins.nix
            ./share/neovim/keymaps.nix
            ./share/neovim/autoCMD.nix
            nixvim.homeManagerModules.nixvim
          ];
        };
      };
    };
}

