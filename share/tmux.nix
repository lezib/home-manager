# Configuration file of tmux and its plugins
{ lib, pkgs, ... }:
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
  programs.tmux = {
    enable = true;
    plugins = [
      {
        plugin = minimal-tmux-status;
      }
    ];
    extraConfig = reader ../config/tmux.conf;
  };
}
