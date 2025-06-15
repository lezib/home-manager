{ lib, pkgs, inputs, ... }:
let 
  reader = path: lib.fileContents path ;
  minimal-tmux-status = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "minimal";
      version = "unstable-2023-01-06";
      src = pkgs.fetchFromGitHub {
        owner= "niksingh710";
        repo= "minimal-tmux-status";
        rev= "de2bb049a743e0f05c08531a0461f7f81da0fc72";
        hash= "sha256-0gXtFVan+Urb79AjFOjHdjl3Q73m8M3wFSo3ZhjxcBA=";
      };
    };
in
{
  home = {
    packages = with pkgs; [
      gnumake
      neovim
      tmux
      zsh
      oh-my-zsh
      fzf
      bat
      nerdfonts
      fd
      eza
    ];

    sessionVariables = {
      EDITOR= "nvim";
    };

    username = "mau";
    homeDirectory = "/home/mau";
    stateVersion = "23.11";
  };

  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    tmux = {
      enable = true;
      plugins = [
        { 
	  plugin = minimal-tmux-status;
	}
      ];
      extraConfig = reader ../config/tmux.conf;
    };

  };
}
