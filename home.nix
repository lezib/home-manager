{ lib, pkgs, inputs, ... }:
let 
  reader = path: lib.fileContents path ;
in
{
  home = {
    packages = with pkgs; [
      gnumake
      tmux
      zsh
      oh-my-zsh
      fzf
      bat
      nerdfetch
      fd
      eza
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
