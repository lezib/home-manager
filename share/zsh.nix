{ lib, pkgs, ... }:
{
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

		dirHashes = {
			dl = "$HOME/Downloads";
		};
	};
}
