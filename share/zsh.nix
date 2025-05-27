{ lib, pkgs, ... }:
let 
	# directory of all functions
	functionsDir = ../shell;

	# Names of the files containing the functions
	modules = [
	  "nvimfzf.zsh"
	  "cdfzf.zsh"
        ];

	makePath = list: builtins.map (name: "/" + functionsDir + "/" + name) list;
	getContent = list: builtins.map (path: lib.fileContents path) list;

	# load all file
	allFunctions = lib.concatStrings (getContent (makePath modules));
in {
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		enableAutosuggestions = true;
		syntaxHighlighting.enable = true;
		autocd = true;

		shellAliases = { 
			c = "clear";
			ls = "ls --color";
			la = "ls -a";
			ll = "ls -al";
			lsl = "ls -l";
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
