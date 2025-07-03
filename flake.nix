{
  description = "My home manager configuration";

  inputs = { 
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
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
        mau = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
	  modules = [ 
	    ./home.nix 
	    ./share/zsh.nix    # config console
	    ./share/tmux.nix   # config tmux
	    ./share/tmuxp.nix  # config setup of tmux env
	    ./share/neovim.nix
	    nixvim.homeManagerModules.nixvim
	  ];
	};
      };
    };
}

