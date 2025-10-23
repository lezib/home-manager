{ lib, pkgs, inputs, ... }:
let 
in {
  home.file."~/.config/obsidian/master/data.json" = {
    enable = true;
    source = ../config/obsidian.json;
  };

  programs.obsidian = {
    enable = true;
    vaults."~/.config/obsidian/master".enable = true;
  };
}
