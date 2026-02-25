{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;
      continuation_prompt = "[▸ ](dimmed white)";
      format = "$character";
      right_format = "$directory$git_branch$git_state$git_status$cmd_duration";

      shell = {
        disabled = false;
        format = "$indicator";
        style = "green";
      };

      git_branch = {
        only_attached = true;
        format = "[\\($symbol $branch]($style)[\\)]($style) ";
        symbol = "";
        style = "bright-yellow";
      };

      git_state = {
        format = "[\($state( $progress_current of $progress_total)\)]($style) ";
        style = "bright-purple bold";
        cherry_pick = "[🍒 PICKING](red)";
        merge = "[ MERGING](red)";
      };

      git_status = {
        ahead = "";
        behind = " ";
        modified = "[󱐋](yellow)";
        untracked = "[](red)";
        stashed = "[ ](bright-yellow)";
        conflicted = " ";
        staged = "[](green)";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "bright-blue";
      };

      directory = {
        truncation_length = 1;
      };

      character = {
        success_symbol = "[ \%](green)";
        error_symbol = "[ \%](red)";
      };
    };
  };
}
