{lib, pkgs, ...}:
let 
  # Names of the files containing the configuration of each extraPlugins
  path = ./extraConfig;

  makePath = list: builtins.map (name: "/" + path + "/" + name) list;
  getContent = list: builtins.map (path: lib.fileContents path) list;

  # load all file
  readAllExtraConfig = conf: lib.concatStrings (getContent (makePath conf));
  #readAllExtraConfig = conf: lib.concatStrings (getContent conf);
in {
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

    # Auto commands to run on specific events
    autoCmd = [
      {
        # autoformat on save for C files
        command = "silent ! clang-format -i %";
        event = [ "BufWritePost" ]; # On write
        pattern = [ "*.c" "*.h" ];  # for C files
      }
      {
        # reset indentation for Lua and Nix files
        command = "set tabstop=2 | set shiftwidth=2";
        event = [ "BufEnter" ]; # On buffer enter
        pattern = [ "*.lua" "*.nix" ];
      }
      {
        # reset indentation for C and Python files
        command = "set tabstop=4 | set shiftwidth=4";
        event = [ "BufEnter" ];
        pattern = [ "*.[hc]" "*.py" ];
      }
    ];

    # all plugins settings
    plugins = {
      # Permanent ones

      # recommandation when typing
      blink-cmp = {
        enable = true;
        settings.keymap = {
          "<C-ENTER>" = [ "select_and_accept" ];
        };
      };

      lualine         .enable = true; # status line
      oil             .enable = true; # file explorer
      indent-blankline.enable = true; # show indentation with vertical lines
      nvim-autopairs  .enable = true; # automatically insert matching brackets, parentheses, etc.
      web-devicons    .enable = true; # file icons
      gitsigns        .enable = true; # show git changes in the sign column
      nvim-surround   .enable = true; # easily delete, change and add such surroundings in pairs
      render-markdown .enable = true; # render markdown files with treesitter

      # for programming language support
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      treesitter-context = {
        enable = true;
        settings = { max_line = 2; };
      };

      # auto completion
      cmp = {
        enable = true;
        autoEnableSources = true;
      };

      # LSP (linguage server protocol) for code analysis, autocompletion, etc.
      lsp-lines = {
        enable = true;
        autoLoad = true;
      };
      lspkind = { enable = true; };
      lsp-status = { enable = true ; };
      lsp = {
        enable = true;
        servers = {
          # add here the language servers you want to use
          lua_ls  .enable = true;
          clangd  .enable = true;
          pyright .enable = true;
          nixd    .enable = true;
          asm_lsp .enable = true;
        };
      };

      # Navigate and visualize the undo history
      undotree = {
        enable = true;
        settings = {
          DiffAutoOpen = true;
        };
      };

      # Fuzzy finder (to find files, search in files, etc.)
      telescope = {
        enable = true;
        keymaps = {
          #"" = {action = ""; options = { desc = ""; }; };
          "<leader>ff" = { action = "find_files"; }; # find files in the current directory by name
          "<leader>fs" = { action = "live_grep"; }; # search for a string in the current directory (like grep)
          "<leader>fc" = { action = "grep_string"; }; # search for the string under the cursor in the current directory
          "<leader>fb" = { action = "buffers"; }; # just list open buffers
          "<leader>fw" = { action = "current_buffer_fuzzy_find"; }; # search for a string in the current buffer
          "<leader>fh" = { action = "highlights"; }; # list all the highlights in the current buffer (like TODO, FIXME, etc.) (for colorscheme)
          "<leader>fo" = { action = "builtin"; }; # list all the builtin pickers of telescope (like find_files, live_grep, etc.) to discover new ones
          "<leader>fg" = { action = "git_status"; }; # list all changed files in the current git repository
        };
      };

      # for notifications and other small features, see 
      snacks = {
        enable = true;
        settings = {
          bigfile.enabled = true;
          notifier = {
            enabled = true;
            timeout = 4000;
          };
          quickfile.enabled = true;
          statuscolumn.enabled = true;
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      # Permanent ones
      nvim-highlight-colors
      neoscroll-nvim
      todo-comments-nvim
      which-key-nvim
    ];

    extraConfigLua = readAllExtraConfig [
      # Permanent ones
      "highlight-colors.lua"
      "neoscroll.lua"
      "todo-comments.lua"
      "which-key.lua"
    ];

    extraPackages = with pkgs; [
      stylua
      nixpkgs-fmt
    ];

    keymaps = [
      # keybind template 
      # { mode = [""]; action = ""; key = ""; options = { silent = false; desc = ""; }; }
      # in order :
      # - mode (n for normal, i for insert, v for visual, t for terminal)
      # - action (the command to execute)
      # - key (the keybind)
      # - options (silent to not show the command in the command line when executing it
      # - desc to show a description in which-key)

      # NOTE : remap to name the space in wich-key
      { mode = ["n"]; action = ""; key = "<leader>e"; options = { silent = false; desc = "File Explorer"; }; }	# Title for which-key
      { mode = ["n"]; action = ""; key = "<leader>f"; options = { silent = false; desc = "Fuzzy Finder"; }; }	# Title for which-key
      { mode = ["n"]; action = ""; key = "<leader>x"; options = { silent = false; desc = "Trouble #TODO"; }; }	# Title for which-key

      # NOTE : remap Window
      { mode = ["n"]; action = "";               key = "<leader>a"; options = { silent = false; desc = "Windows"; }; } # title for which-key
      { mode = ["n"]; action = ":terminal<CR>a"; key = "<leader>at"; options = { silent = false; desc = "Terminal"; }; } # open a terminal in neovim
      { mode = ["n"]; action = ":only<CR>";   key = "<leader>ao"; options = { silent = false; desc = "Only current"; }; } # close all other buffers
      { mode = ["n"]; action = ":vsplit<CR>"; key = "<leader>av"; options = { silent = false; desc = "Vsplit"; }; } # split the window vertically
      { mode = ["n"]; action = ":split<CR>";  key = "<leader>as"; options = { silent = false; desc = "Hsplit"; }; } # split the window horizontally

      # NOTE : navigation in multiple buffers
      { mode = ["n"]; action = "<C-w>h"; key = "<leader>ah"; options = { silent = false; }; } 
      { mode = ["n"]; action = "<C-w>j"; key = "<leader>aj"; options = { silent = false; }; }
      { mode = ["n"]; action = "<C-w>k"; key = "<leader>ak"; options = { silent = false; }; }
      { mode = ["n"]; action = "<C-w>l"; key = "<leader>al"; options = { silent = false; }; }
      #{ mode = ["n"]; action = "<cmd>lua require('undotree').toggle()<cr>"; key = "<leader>u"; options = { silent = false; desc = "Undotree"; };}

      # NOTE : remap mouvements
      { mode = ["n"]; action = "<C-d> zz"; key = "<C-d>"; options = { silent = false; }; } # auto center
      { mode = ["n"]; action = "<C-u> zz"; key = "<C-u>"; options = { silent = false; }; } # ''

      # NOTE : remap copy in clipboard
      { mode = ["n"]; action = ''"+Y''; key = "<leader>y"; options = { silent = false; }; }
      { mode = ["v"]; action = ''"+y''; key = "<leader>y"; options = { silent = false; }; }
      { mode = ["n"]; action = ''"+D''; key = "<leader>d"; options = { silent = false; }; }
      { mode = ["v"]; action = ''"+D''; key = "<leader>d"; options = { silent = false; }; }
      { mode = ["n"]; action = ''"+p''; key = "<leader>p"; options = { silent = false; }; }

      # NOTE : remap file Explorer
      { mode = ["n"]; action = "<cmd>Oil --float<CR>";  key = "<leader>ee"; options = { silent = false; desc = "Open"; }; }
      { mode = ["n"]; action = "<cmd>bprev<CR>";        key = "<leader>eh"; options = { silent = false; desc = "prev buffer"; }; }
      { mode = ["n"]; action = "<cmd>bnext<CR>";        key = "<leader>el"; options = { silent = false; desc = "next buffer"; }; }
      { mode = ["n"]; action = "<cmd>bdelete!<CR>";     key = "<leader>er"; options = { silent = false; desc = "delete buffer"; }; }

      # NOTE : remap for undotree
      { mode = ["n" "v"]; action = "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>"; key = "<leader>u"; options = { silent = false; desc = "Undotree"; }; }

      # NOTE : remap déplacement de lignes
      { mode = ["n"]; action = "J";                 key = "H";      options = { silent = false; }; }
      { mode = ["n"]; action = ":m -2<CR>==";       key = "<A-k>";  options = { silent = false; desc = "Move l up"; }; }
      { mode = ["n"]; action = ":m +1<CR>==";       key = "<A-j>";  options = { silent = false; desc = "Move l down"; }; }
      { mode = ["v"]; action = ":m '<-2<CR>gv=gv";  key = "<A-k>";  options = { silent = false; desc = "Move select up"; }; }
      { mode = ["v"]; action = ":m '>+1<CR>gv=gv";  key = "<A-j>";  options = { silent = false; desc = "Move select up"; }; }

      # NOTE : remap pratique
      { mode = ["t"]; action = "<C-\\><C-n>";       key = "<Esc>";      options = { silent = false; }; }
      { mode = ["n"]; action = "zz";                key = "<leader>k";  options = { silent = false; desc = "Center view"; }; }
      { mode = ["n"]; action = "Gzz";               key = "G";          options = { silent = false; desc = "Go full down"; }; }
      { mode = ["n"]; action = "vim.lsp.buf.hover"; key = "<C-h>";      options = { silent = false; desc = "analyse under cursor"; }; }
      # use ctrl-Backspace to delete the whole word in insert mode
      { mode = ["i"]; action = "<C-W>";             key = "<C-BS>";     options = { silent = false; desc = "delete whole word"; }; }

      # NOTE : remap folding
      #{ mode = ["n"]; action = ""; key = "<leader>s"; options = { silent = false; desc = "Fold"; }; }
      { mode = ["n"]; action = "za";                              key = "<leader>st"; options = { silent = false; desc = "toggle fold"; }; }
      { mode = ["n"]; action = "f{zf%";                           key = "<leader>s{"; options = { silent = false; desc = "fold {}"; }; }
      { mode = ["n"]; action = "<cmd>set foldmethod=indent<CR>";  key = "<leader>sf"; options = { silent = false; desc = "fold over indent"; }; }

      # NOTE : map lsp
      {
        mode = ["n"];
        action = "<cmd>lua vim.diagnostic.config({ virtual_lines = true, virtual_text = false })<CR>";
        key = "<leader>xl";
        options = { silent = false; desc = "Full lines mode"; };
      }
      {
        mode = ["n"];
        action = "<cmd>lua vim.diagnostic.config({ virtual_lines = false, virtual_text = true })<CR>";
        key = "<leader>xt";
        options = { silent = false; desc = "Partial lines mode"; };
      }
      {
        mode = ["n"];
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        key = "<leader>xf";
        options = { silent = false; desc = "Quick fix"; }; }
    ];
  };
}
