# Configuration file of tmuxp
{ lib, pkgs, ... }:
{
  programs.tmux.tmuxp = {
    enable = true;
  };

  home.file.".tmuxp" = {
    enable = true;
    source = ../config/tmuxp;
  };
}
