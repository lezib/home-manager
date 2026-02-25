{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = true;
      continuation_prompt = "[▸ ](dimmed white)";
      format = " % ";
      right_format = "$directory ($git_branch) $git_state $cmd_duration";

      git_branch = {
        only_attached = true;
        format = "[$symbol$branch]($style) ";
        symbol = "שׂ";
        style = "bright-yellow bold";
      };

      git_status = {
        style = "bright-purple bold";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "bright-blue";
      };
    };
  };
}
