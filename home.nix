{ lib, pkgs, inputs, ... }:
let 
  reader = path: lib.fileContents path ;
in
  {
  fonts.fontconfig = {
    enable = true;
  };

  home = {
    packages = [
      pkgs.gnumake # basics gcc commandes
      pkgs.tmux # multiplexer
      pkgs.zsh
      pkgs.oh-my-zsh
      pkgs.fzf # fuzzy find
      pkgs.bat
      pkgs.fd
      pkgs.eza # better ls
      pkgs.ripgrep # grep
      pkgs.nerd-fonts.caskaydia-mono
      pkgs.xclip # clipboard manager
      pkgs.xwayland-satellite # for niri
      inputs.niri.packages.${pkgs.system}.niri # version of the overlay
    ];

    sessionVariables = {
      EDITOR= "nvim";
    };

    stateVersion = "24.11";
  };

  programs = {
    #home-manager = {
    #enable = true;
    #};

    git = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };


  xdg.configFile."niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "us"
            }
        }
    }

    binds {
        Mod+Return { spawn "kitty"; }
        Mod+Q { close-window; }
    }
  '';
}
