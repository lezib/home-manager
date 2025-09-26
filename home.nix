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
			gnumake # basics gcc commandes
			tmux # multiplexer
			zsh
			oh-my-zsh
			fzf # fuzzy find
			bat 
			fd
			eza # better ls
			ripgrep # grep
			nerd-fonts.caskaydia-mono
			xclip # clipboard manager
			go # the language
			docker
		];

		sessionVariables = {
			EDITOR= "nvim";
		};

		stateVersion = "24.11";
	};

	programs = {
                #home-manager = {
                        #enable = true;
                #};

		git = {
			enable = true;
		};

		fzf = {
			enable = true;
			enableZshIntegration = true;
		};


	};
}
