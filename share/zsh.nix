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
      ls = "eza --icons --color=always";
      la = "eza -a --icons --color=always";
      ll = "eza -al --icons --color=always";
      lsl = "eza -l --icons --color=always";
      gs = "git status";
      ga = "git add";
      gm = "git commit -m";
      gt = "git tag -ma";
      gp = "git push";
      gpt = "git push --follow-tags";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
      ];
      theme = "terminalparty";
    };

    initContent = allFunctions;

    dirHashes = {
      dl = "$HOME/Downloads";
    };
  };
}
