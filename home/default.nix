{ lib, pkgs, ... }:
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
