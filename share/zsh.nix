{ lib, pkgs, inputs, ... }:
let 
  # directory of all functions
  functionsDir = ../shell;

  # Names of the files containing the functions
  modules = [
    "nvimfzf.zsh"
    "cdfzf.zsh"
    "tmuxpfzf.zsh"
    "autopush.zsh"
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

      # git aliases
      gs = "git status";
      gl = "git log";
      ga = "git add";
      gm = "git commit";
      gmm = "git commit -m";
      gt = "git tag -ma";
      gp = "git push";
      gpt = "git push --follow-tags";
      gsw = "git switch";
      gb = "git branch";
      # advanced
      glg = "git log --all --oneline --graph";
      gap = "git add -p";
      gsh = "git show";
      gg = "autopush"; # define in shellscripts
      sql-server = "initdb --locale \"$LANG\" -E UTF8; postgres -k \"$PGHOST\"";
      sql-setup = "createuser -s postgres; createdb -U postgres roger_roger; pg_restore -U postgres -O -d roger_roger ~/afs/ing1/sql/roger_roger.dump";
      sql-run = "psql roger_roger";
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
