{ config, pkgs, ... }:

{
  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "22.05";
    # Configuring arbitrary files.
    file = {
      "/.scripts/pfetch" = { # pfetch script.
        executable = true;
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/baduhai/dotfiles/master/scripts/pfetch";
          sha256 = "taTut791iDEe59kgWaFeS6I+B8b0F69/7KomCFGnocs=";
        };
      };
    };
  };

  # Allow fonts installed by home-manager to be used elsewhere
  fonts.fontconfig.enable = true;

  # Configuration of programs.
  programs = {
    # Allow home-manager to manage itself.
    home-manager.enable = true;
    # Allow bash to be managed by home-manager.
    bash = {
      enable = true;
      historyFile = "~/.cache/bash_history";
    };
    # Fish configuration.
    fish = {
      enable = true;
      shellAliases = {
        g = "git";
        nano = "micro";
        wget = "wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";
      };
      functions = {
        fish_greeting = ''
          set -x PF_INFO ascii title os kernel uptime pkgs memory palette
          eval $HOME/.scripts/pfetch
        '';
        pacin = "nix-env -iA nixos.$argv";
        pacre = "nix-env -e $argv\; nix-collect-garbage";
      };
      shellInit = ''
         set -g theme_date_format "+%H:%M"
         set -g theme_date_timezone Europe/Berlin
         set -g theme_avoid_ambiguous_glyphs yes
         set -g theme_color_scheme dark
         set -g theme_nerd_fonts yes
         set -g theme_display_git_default_branch yes
         set -g -x FONTCONFIG_FILE ${pkgs.fontconfig.out}/etc/fonts/fonts.conf
      '';
      plugins  = [
        {
          name = "bobthefish";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "theme-bobthefish";
            rev = "14a6f2b317661e959e13a23870cf89274f867f12";
            sha256 = "kl6XR6IFk5J5Bw7/0/wER4+TnQfC18GKxYbt9C+YHJ0=";
          };
        }
        {
          name = "bang-bang";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-bang-bang";
            rev = "f969c618301163273d0a03d002614d9a81952c1e";
            sha256 = "A8ydBX4LORk+nutjHurqNNWFmW6LIiBPQcxS3x4nbeQ=";
          };
        }
      ];
    };
    # tmux fonconfiguration.
    tmux = {
      enable = true;
      clock24 = true;
      extraConfig = "set -g mouse on";
    };
    # Git configuration.
    git = {
      enable = true;
      diff-so-fancy.enable = true;
      userName = "William";
      userEmail = "williamhai@hotmail.com";
    };  
  };
}
