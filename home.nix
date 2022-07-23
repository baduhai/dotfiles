{ config, pkgs, ... }:

{
  home = {
    username = "foxtrot";
    homeDirectory = "/home/foxtrot";
    stateVersion = "22.05";
    pointerCursor = { # Good god, cursor theming is a bitch.
      size = 24;
      gtk.enable = true;
      x11.enable = true;
      name = "breeze_cursors";
      package = pkgs.breeze-icons;
    };
    # Configuring arbitrary files.
    file = {
      "/.scripts/pfetch" = { # pfetch script.
        executable = true;
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/baduhai/dotfiles/master/.scripts/pfetch";
          sha256 = "Z7f/W6ayCSAhUswOG8SzBZZjeNX1vh4G4ZBRuSU5sFo=";
        };
      };
      ".config/MangoHud/MangoHud.conf".source = pkgs.fetchurl { # MangoHud config.
        url = "https://raw.githubusercontent.com/baduhai/dotfiles/master/.config/MangoHud/MangoHud.conf";
        sha256 = "VZoyVelhNy+BZ0Ep7qWmMwuLZu2pTu/MZlIt8clS3zo=";
      };
      # Autosart applications.
      ".config/autostart/org.kde.yakuake.desktop".source = "/var/run/current-system/sw/share/applications/org.kde.yakuake.desktop";
      ".config/autostart/megasync.desktop".source = "/var/run/current-system/sw/share/applications/megasync.desktop";
    };
  };

  # Allow fonts installed by home-manager to be used elsewhere
  fonts.fontconfig.enable = true;

  # GTK configuration.
  gtk = {
    enable = true;
    font = { name = "Noto Sans"; size = 10; };
    theme = { package = pkgs.breeze-gtk; name = "Breeze"; };
    iconTheme = { package = pkgs.breeze-icons; name = "Breeze"; };
  };

  # User services configuration.
  services.kdeconnect.enable = true;

  # xdg spec.
  xdg = {
    enable = true;
    desktopEntries = {
      steamGamepadUi = { # Menu entry for steam gamepadui.
         terminal = false;
        icon = "steam_deck";
        exec = "steam -gamepadui";
        name = "Steam (Gamepad UI)";
        categories = [ "Game" ];
      };
    };
  };

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
        pacre = "nix-env -e $argv";
      };
      shellInit = ''
         set -g theme_date_format "+%H:%M"
         set -g theme_date_timezone Europe/Berlin
         set -g theme_avoid_ambiguous_glyphs yes
         set -g theme_color_scheme dark
         set -g theme_nerd_fonts yes
         set -g theme_display_git_default_branch yes
         set -g -x PF_INFO ascii os kernel uptime pkgs memory shell palette
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
    # Kitty terminal emulator configuration.
    kitty = {
      enable = true;
      theme = "Afterglow";
      font = {
        name = "Hack Nerd Font";
        size = 10;
      };
      settings = {
        tab_bar_edge = "top";
        tab_switch_strategy = "left";
        tab_bar_min_tabs = 1;
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_bar_background = "#3b3b3b";
        tab_bar_margin_color = "#3b3b3b";
        tab_title_template = "{index}: {f'{title[:6]}…{title[-6:]}' if title.rindex(title[-1]) + 1 > 13 else title}";
        remember_window_size = "no";
        initial_window_width = "120c";
        initial_window_height = "42c";
        confirm_os_window_close = "-2";
      };
    };
    # Git configuration.
    git = {
      enable = true;
      diff-so-fancy.enable = true;
      userName = "William";
      userEmail = "williamhai@hotmail.com";
    };
    # Mangohud configuration.
    mangohud = {
      enable            = true;
      enableSessionWide = true;
    };
  };
}
