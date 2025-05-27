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
      #function _nvimfzf {
        #export FZF_DEFAULT_COMMAND='fdfind --no-ignore --hidden --exclude .git'
	#DIRECTORY_PRINT=$(echo -e "[DIRECTORY]\n")
	#EXA_OPTIONS="--icons -la --color=always"
	#BAT_OPTIONS="--number -f --force-colorization"
#
	#NVIM_FZF_PREVIEW="if [[ -d {} ]]; then echo -e \"[DIRECTORY]\n\"; exa $EXA_OPTIONS {}; else batcat $BAT_OPTIONS {}; fi"
	#dest_find=$(fzf --scheme=path  --preview "$NVIM_FZF_PREVIEW")
#
	#if [[ ! -z "$dest_file" ]]; then
	  #cd "$dest_file" && nvim .
	#fi
      #}
    #'';
}
