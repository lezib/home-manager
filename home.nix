{ lib, pkgs, inputs, ... }:
let 
  reader = path: lib.fileContents path ;
in
{
  fonts.fontconfig = {
  	enable = true;
  };

  home = {
    packages = with pkgs; [
      gnumake
      tmux
      zsh
      oh-my-zsh
      fzf
      bat
      fd
      eza
	  ripgrep
	  nerd-fonts.caskaydia-mono
	  xclip
	  go
    ];

    sessionVariables = {
      EDITOR= "nvim";
    };

    username = "mau";
    homeDirectory = "/home/mau";
    stateVersion = "24.11";
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

  };
}
