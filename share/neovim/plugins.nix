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
  programs.nixvim = {
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
  };
}

