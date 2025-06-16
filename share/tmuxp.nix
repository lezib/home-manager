# Configuration file of tmuxp
{ lib, pkgs, ... }:
{
  programs.tmux.tmuxp = {
    enable = true;
  };

  home.file.".tmuxp".source = ../config/tmuxp;
}
