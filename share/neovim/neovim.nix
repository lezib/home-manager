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
    enable = true;
    globals.mapleader = " ";

    colorschemes.gruvbox = {
      enable = true;
    };

    opts = {

      termguicolors = true;
      number = true;		# Show number on left
      relativenumber = true;    # Relative number
      cursorline = true;	# Show the line where the cursor is

      undofile = true;		# Save undo history
      splitright = true;
      splitbelow = true;

      list = true;
      #listchars = {tab = "", trail = "", nbsp = ""};

      scrolloff = 7;
      shiftwidth = 4;		# Set auto tabulation at 4 spaces
      tabstop = 4;			# Set tabulation at 4 spaces
      expandtab = true;		# Put spaces instead of tabulation
      colorcolumn = "80";
    };

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

    autoCmd = [
      {
        command = "silent ! clang-format -i %";
        event = [ "BufWritePost" ];
        pattern = [ "*.c" "*.h" ];
      }
      {
        command = "set tabstop=2 | set shiftwidth=2";
        event = [ "BufEnter" ];
        pattern = [ "*.lua" "*.nix" ];
      }
    ];

    plugins = {
      # Permanent ones
      blink-cmp = {
        enable = true;
        settings.keymap = {
          "<C-ENTER>" = [ "select_and_accept" ];
        };
      };
      lualine.enable = true;
      oil.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      web-devicons.enable = true;
      gitsigns.enable = true;
      # lspconfig.enable = true;
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

      cmp = {
        enable = true;
        autoEnableSources = true;
      };

      lsp-lines = {
        enable = true;
        autoLoad = true;
      };
      lspkind = { enable = true; };
      lsp-status = { enable = true ; };
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          clangd.enable = true;
          markdown_oxide.enable = true;
          pyright.enable = true;
          gopls.enable = true;
          nixd.enable = true;
          ocamllsp.enable = true;
          yamlls.enable = true;
          asm_lsp.enable = true;
        };
      };

      undotree = {
        enable = true;
        settings = {
          DiffAutoOpen = true;
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          #"" = {action = ""; options = { desc = ""; }; };
          "<leader>ff" = { action = "find_files"; };
          "<leader>fr" = { action = "oldfiles"; };
          "<leader>fs" = { action = "live_grep"; };
          "<leader>fc" = { action = "grep_string"; };
          #"<leader>ft" = { action = "TodoTelescope"; };
          "<leader>fb" = { action = "buffers"; };
          "<leader>fw" = { action = "current_buffer_fuzzy_find"; };

        };
      };
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
      # Temporary ones
    };

    extraPlugins = with pkgs.vimPlugins; [
      # Permanent ones
      nvim-highlight-colors
      neoscroll-nvim
      todo-comments-nvim
      which-key-nvim

      # Temporary ones
    ];

    extraConfigLua = readAllExtraConfig [
      # Permanent ones
      "highlight-colors.lua"
      "neoscroll.lua"
      "todo-comments.lua"
      "which-key.lua"

      # Temporary ones
    ];

    extraPackages = with pkgs; [
      stylua
      nixpkgs-fmt
    ];

    keymaps = [
      # keybind template 
      #{ mode = [""]; action = ""; key = ""; options = { silent = false; desc = ""; }; }

      # NOTE : remap to name the space in wich-key
      { mode = ["n"]; action = ""; key = "<leader>e"; options = { silent = false; desc = "File Explorer"; }; }	# Title for which-key
      { mode = ["n"]; action = ""; key = "<leader>f"; options = { silent = false; desc = "Fuzzy Finder"; }; }	# Title for which-key
      { mode = ["n"]; action = ""; key = "<leader>x"; options = { silent = false; desc = "Trouble #TODO"; }; }	# Title for which-key

      # NOTE : remap Window
      { mode = ["n"]; action = ""; key = "<leader>a"; options = { silent = false; desc = "Windows"; }; } # title for which-key
      { mode = ["n"]; action = ":terminal<CR>a"; key = "<leader>at"; options = { silent = false; desc = "Terminal"; }; }
      { mode = ["n"]; action = ":only<CR>"; key = "<leader>ao"; options = { silent = false; desc = "Only current"; }; }
      { mode = ["n"]; action = ":vsplit<CR>"; key = "<leader>av"; options = { silent = false; desc = "Vsplit"; }; }
      { mode = ["n"]; action = ":split<CR>"; key = "<leader>as"; options = { silent = false; desc = "Hsplit"; }; }

      # NOTE : navigation in multiple buffers
      #{ mode = ["n"]; action = "<cmd>lua require('undotree').toggle()<cr>"; key = "<leader>u"; options = { silent = false; desc = "Undotree"; }; }
      { mode = ["n"]; action = "<C-w>h"; key = "<leader>ah"; options = { silent = false; }; }
      { mode = ["n"]; action = "<C-w>j"; key = "<leader>aj"; options = { silent = false; }; }
      { mode = ["n"]; action = "<C-w>k"; key = "<leader>ak"; options = { silent = false; }; }
      { mode = ["n"]; action = "<C-w>l"; key = "<leader>al"; options = { silent = false; }; }

      # NOTE : remap mouvements
      { mode = ["n"]; action = "<C-d> zz"; key = "<C-d>"; options = { silent = false; }; }
      { mode = ["n"]; action = "<C-u> zz"; key = "<C-u>"; options = { silent = false; }; }

      # NOTE : remap copy in clipboard
      { mode = ["n"]; action = ''"+Y''; key = "<leader>y"; options = { silent = false; }; }
      { mode = ["v"]; action = ''"+y''; key = "<leader>y"; options = { silent = false; }; }
      { mode = ["n"]; action = ''"+D''; key = "<leader>d"; options = { silent = false; }; }
      { mode = ["v"]; action = ''"+D''; key = "<leader>d"; options = { silent = false; }; }
      { mode = ["n"]; action = ''"+p''; key = "<leader>p"; options = { silent = false; }; }

      # NOTE : remap file Explorer
      { mode = ["n"]; action = "<cmd>Oil --float<CR>"; key = "<leader>ee"; options = { silent = false; desc = "Open"; }; }
      { mode = ["n"]; action = "<cmd>bprev<CR>"; key = "<leader>eh"; options = { silent = false; desc = "prev buffer"; }; }
      { mode = ["n"]; action = "<cmd>bnext<CR>"; key = "<leader>el"; options = { silent = false; desc = "next buffer"; }; }
      { mode = ["n"]; action = "<cmd>bdelete!<CR>"; key = "<leader>er"; options = { silent = false; desc = "next buffer"; }; }

      { mode = ["n" "v"]; action = "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>"; key = "<leader>u"; options = { silent = false; desc = "Undotree"; }; }

      # NOTE : remap déplacement de lignes
      { mode = ["n"]; action = "J"; key = "H"; options = { silent = false; }; }
      { mode = ["n"]; action = ":m -2<CR>=="; key = "<A-k>"; options = { silent = false; desc = "Move l up"; }; }
      { mode = ["n"]; action = ":m +1<CR>=="; key = "<A-j>"; options = { silent = false; desc = "Move l down"; }; }
      { mode = ["v"]; action = ":m '<-2<CR>gv=gv"; key = "<A-k>"; options = { silent = false; desc = "Move select up"; }; }
      { mode = ["v"]; action = ":m '>+1<CR>gv=gv"; key = "<A-j>"; options = { silent = false; desc = "Move select up"; }; }

      # NOTE : remap pratique
      { mode = ["t"]; action = "<C-\\><C-n>"; key = "<Esc>"; options = { silent = false; }; }
      { mode = ["n"]; action = "zz"; key = "<leader>k"; options = { silent = false; desc = "Center view"; }; }
      { mode = ["n"]; action = "Gzz"; key = "G"; options = { silent = false; desc = "Go full down"; }; }
      { mode = ["n"]; action = "vim.lsp.buf.hover"; key = "<C-h>"; options = { silent = false; desc = "analyse under cursor"; }; }
      # use ctrl-Backspace to delete the whole word in insert mode
      { mode = ["i"]; action = "<C-W>"; key = "<C-BS>"; options = { silent = false; desc = "delete whole word"; }; }

      # NOTE : remap folding
      #{ mode = ["n"]; action = ""; key = "<leader>s"; options = { silent = false; desc = "Fold"; }; }
      { mode = ["n"]; action = "za"; key = "<leader>st"; options = { silent = false; desc = "toggle fold"; }; }
      { mode = ["n"]; action = "f{zf%"; key = "<leader>s{"; options = { silent = false; desc = "fold {}"; }; }
      { mode = ["n"]; action = "<cmd>set foldmethod=indent<CR>"; key = "<leader>sf"; options = { silent = false; desc = "fold over indent"; }; }
      # NOTE : map lsp
      { mode = ["n"]; action = "<cmd>lua vim.diagnostic.config({ virtual_lines = true, virtual_text = false })<CR>"; key = "<leader>xl"; options = { silent = false; desc = "Full lines mode"; }; }
      { mode = ["n"]; action = "<cmd>lua vim.diagnostic.config({ virtual_lines = false, virtual_text = true })<CR>"; key = "<leader>xt"; options = { silent = false; desc = "Partial lines mode"; }; }
      { mode = ["n"]; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; key = "<leader>xf"; options = { silent = false; desc = "Quick fix"; }; }
    ];
  };
}
