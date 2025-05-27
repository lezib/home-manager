{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
      gnumake
      neovim
      tmux
      zsh
      oh-my-zsh
    ];

    sessionVariables = {
      EDITOR= "nvim";
    };

    username = "mau";
    homeDirectory = "/home/mau";
    stateVersion = "23.11";
  };
  
  # import zsh configuration
  # programs.zsh = import ./zsh.nix { inherit lib pkgs; };

    #loginShellInit = ''
      ## ajout de bind
      #bindkey '^@' autosuggest-accept
      #bindkey '^E' autosuggest-execute
      #bindkey -s ^f "_nvimfzf\n"
#
      ## add rename of commands
      #alias vim=nvim
      #alias fd=fdfind
#
    #'';
}
