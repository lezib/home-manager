{ lib, pkgs, inputs, ... }:
let 
	# directory of all functions
	functionsDir = ../shell;

	# Names of the files containing the functions
	modules = [
	  "nvimfzf.zsh"
	  "cdfzf.zsh"
	  "tmuxpfzf.zsh"
    ];

	makePath = list: builtins.map (name: "/" + functionsDir + "/" + name) list;
	getContent = list: builtins.map (path: lib.fileContents path) list;

	# load all file
	allFunctions = lib.concatStrings (getContent (makePath modules));
in {
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		autocd = true;

		shellAliases = { 
			c = "clear";
			ls = "eza --icons";
			la = "eza -a --icons";
			ll = "eza -al --icons";
			lsl = "eza -l --icons";
		};

		oh-my-zsh = {
			enable = true;
			plugins = [
				"sudo"
			];
			theme = "terminalparty";
		};
		
		initExtra = allFunctions;

		dirHashes = {
			dl = "$HOME/Downloads";
		};
	};
}
