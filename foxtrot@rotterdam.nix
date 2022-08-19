{ config, pkgs, ... }:

{
  home = {
    username = "foxtrot";
    homeDirectory = "/home/foxtrot";
    stateVersion = "22.05";
    pointerCursor = {
      size = 24;
      gtk.enable = true;
      x11.enable = true;
      name = "breeze_cursors";
      package = pkgs.breeze-icons;
    };
    sessionVariables = {
      EDITOR = "micro";
    };
    file = {
      "/.scripts/pfetch" = {
        executable = true;
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/baduhai/dotfiles/master/scripts/pfetch";
          sha256 = "UEfTG1XCuN2GlpPz1gdQ5mxgutlX2XL58rGOqtaUgV4=";
        };
      };
      ".local/share/color-schemes/BreezeDarkNeutral.colors".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/hellokartikey/breeze-dark-neutral/main/BreezeDarkNeutral.colors";
        sha256 = "OSnUslO7fxBZETCGcPtgtX3SiKaq3sz0/K70wDIj90A=";
      };
      ".config/MangoHud/MangoHud.conf".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/baduhai/dotfiles/master/MangoHud/MangoHud.conf";
        sha256 = "VZoyVelhNy+BZ0Ep7qWmMwuLZu2pTu/MZlIt8clS3zo=";
      };
      ".config/kitty/search.py".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/baduhai/dotfiles/master/kitty/search.py";
        sha256 = "mi5GB8CmWafAdp3GYnsQM4VHpXhuaVYX7YDT+9426Jc=";
      };
      ".config/kitty/scroll_mark.py".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/baduhai/dotfiles/master/kitty/scroll_mark.py";
        sha256 = "Abif6LIOCiXyDdQMZ4pQnLK++It0VYIM+WE7Oydwkfo=";
      };
      ".config/autostart/org.kde.yakuake.desktop".source = config.lib.file.mkOutOfStoreSymlink "/var/run/current-system/sw/share/applications/org.kde.yakuake.desktop";
      ".config/autostart/megasync.desktop".source = config.lib.file.mkOutOfStoreSymlink "/var/run/current-system/sw/share/applications/megasync.desktop";
    };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    font = { name = "Inter"; size = 10; };
    theme = { package = pkgs.breeze-gtk; name = "Breeze"; };
    iconTheme = { package = pkgs.breeze-icons; name = "Breeze"; };
  };

  services = {
    pass-secret-service.enable = true;
    kdeconnect.enable = true;
    home-manager.autoUpgrade = {
      enable = true;
      frequency = "*-*-* 20:00:00";
    };
  };

  xdg = {
    enable = true;
    desktopEntries = {
      steamGamepadUi = {
         terminal = false;
        icon = "steam_deck";
        exec = "steam -gamepadui";
        name = "Steam (Gamepad UI)";
        categories = [ "Game" ];
      };
    };
  };

  programs = {
    home-manager.enable = true;
    password-store.enable = true;
    bash = {
      enable = true;
      historyFile = "~/.cache/bash_history";
    };
    fish = {
      enable = true;
      shellAliases = {
        g = "git";
        nano = "micro";
        wget = "wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";
        ssh = "kitty +kitten ssh";
      };
      functions = {
        fish_greeting = ''
          set -x PF_INFO ascii title os kernel uptime wm memory palette
          eval $HOME/.scripts/pfetch
        '';
        pacin = "nix-env -iA nixos.$argv";
        pacre = "nix-env -e $argv\; nix-collect-garbage";
      };
      shellInit = ''
        set -g PF_INFO ascii title os kernel uptime wm memory palette
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
            rev = "2dcfcab653ae69ae95ab57217fe64c97ae05d8de";
            sha256 = "jBbm0wTNZ7jSoGFxRkTz96QHpc5ViAw9RGsRBkCQEIU=";
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
        {
          name = "fzf.fish";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "v9.2";
            sha256 = "XmRGe39O3xXmTvfawwT2mCwLIyXOlQm7f40mH5tzz+s=";
          };
        }
      ];
    };
    kitty = {
      enable = true;
      theme = "Afterglow";
      font = {
        name = "Hack Nerd Font";
        size = 10;
      };
      keybindings = {
        "kitty_mod+f" = "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
      };
      settings = {
        shell = "fish";
        cursor_shape = "block";
        tab_switch_strategy = "left";
        tab_bar_min_tabs = 1;
        tab_bar_margin_width = 2;
        tab_bar_margin_height = "3 3";
        tab_bar_style = "fade";
        tab_fade = 0;
        tab_bar_background = "#3b3b3b";
        tab_bar_margin_color = "#3b3b3b";
        tab_title_template = "{fmt.bg._3b3b3b}{fmt.fg._202020}{fmt.fg.default}{fmt.bg._202020}{fmt.fg._c6c6c6} {title} {fmt.fg.default}{fmt.bg.default}{fmt.fg._202020}{fmt.fg.default}";
        active_tab_title_template = "{fmt.bg._3b3b3b}{fmt.fg._fcfcfc}{fmt.fg.default}{fmt.bg._fcfcfc}{fmt.fg._3b3b3b} {title} {fmt.fg.default}{fmt.bg.default}{fmt.fg._fcfcfc}{fmt.fg.default}";
        initial_window_width = "120c";
        initial_window_height = "36c";
        remember_window_size = "no";
        confirm_os_window_close = "-2";
      };
    };
    tmux = {
      enable = true;
      clock24 = true;
      extraConfig = "set -g mouse on";
    };
    git = {
      enable = true;
      diff-so-fancy.enable = true;
      userName = "William";
      userEmail = "williamhai@hotmail.com";
    };
    mangohud = {
      enable            = true;
      enableSessionWide = true;
    };
  };
}
