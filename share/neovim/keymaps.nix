{...}:
{
  programs.nixvim = {
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
        options = { silent = false; desc = "Quick fix"; }; 
      }
      {
        mode = ["n"];
        action = "<cmd>silent ! clang-format -i %<CR>";
        key = "<leader>r";
        options = { silent = false; desc = "Force clang-format"; }; 
      }
    ];
  };
}
