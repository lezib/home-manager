{lib, pkgs, ...}:
{
  # For all documentation about the options, see https://nix-community.github.io/nixvim/index.html
  programs.nixvim = {
    enable = true;
    globals.mapleader = " "; # the prefix of custom command

    # colorscheme
    colorschemes.gruvbox = {
      enable = true;
    };

    opts = {
      termguicolors = true; # Enable 24-bit RGB color in the TUI
      number = true;		# Show number on left
      relativenumber = true;    # Relative number
      cursorline = true;	# Show the line where the cursor is

      undofile = true;		# Save undo history
      splitright = true;  # rule for split
      splitbelow = true;

      list = true;
      #listchars = {tab = "", trail = "", nbsp = ""}; # you can set the character to show for tab, trailing spaces and non-breaking spaces

      scrolloff = 7;    # Set the number of lines to keep above and below the cursor
      shiftwidth = 4;		# Set auto tabulation at 4 spaces
      tabstop = 4;			# Set tabulation at 4 spaces
      expandtab = true;		# Put spaces instead of tabulation
      colorcolumn = "80";
    };

    # LSP diagnostics settings
    diagnostic.settings = {
      # virtual_lines.current_line = true;
      virtual_text = true;
      signs.text = {
        ERROR = "";
        WARN = "";
        HINT = "󰠠";
        INFO = "";
      };
    };
  };
}
