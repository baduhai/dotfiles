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
    packages = with pkgs; [
      syncthingtray
    ];
    sessionVariables = {
      EDITOR = "micro";
    };
    file = {
      # Dotfiles that can't be managed via home-manager
      ".scripts/pfetch" = {
        executable = true;
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/baduhai/dotfiles/master/scripts/pfetch";
          sha256 = "UEfTG1XCuN2GlpPz1gdQ5mxgutlX2XL58rGOqtaUgV4=";
        };
      };
      ".local/share/color-schemes/BreezeDarkNeutral.colors".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/baduhai/dotfiles/master/color-schemes/BreezeDarkNeutral.colors";
        sha256 = "Fw5knhpV47HlgYvbHFzfi6M6Tk2DTlAuFUYc2WDDBc8=";
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
      # Autostart programs
      ".config/autostart/org.kde.yakuake.desktop".source = config.lib.file.mkOutOfStoreSymlink "/var/run/current-system/sw/share/applications/org.kde.yakuake.desktop";
      ".config/autostart/megasync.desktop".source = config.lib.file.mkOutOfStoreSymlink "/var/run/current-system/sw/share/applications/megasync.desktop";
      ".config/autostart/koi.desktop".source = config.lib.file.mkOutOfStoreSymlink "/var/run/current-system/sw/share/applications/koi.desktop";
      # Fix flatpak fonts, themes, icons and cursor
      ".icons/breeze_cursors".source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/icons/breeze_cursors";
      ".local/share/flatpak/overrides/global".text = "[Context]\nfilesystems=/run/current-system/sw/share/X11/fonts:ro;~/.local/share/color-schemes:ro;xdg-config/gtk-3.0:ro;/nix/store:ro;~/.icons:ro";
    };
  };

  fonts.fontconfig.enable = true; # Allow fonts installed by home-manager to be available session wide

  gtk = {
    enable = true;
    font = { name = "Inter"; size = 10; };
    theme = { package = pkgs.breeze-gtk; name = "Breeze"; };
    iconTheme = { package = pkgs.breeze-icons; name = "Breeze"; };
  };

  services = {
    kdeconnect.enable = true;
    syncthing = {
      enable = true;
      tray = {
        enable = true;
        package = pkgs.writeShellScriptBin "syncthingtray" "exec ${pkgs.syncthingtray}/bin/syncthingtray --wait" // { pname = "syncthingtray"; }; # Override synctray so it waits for a system tray
      };
    };
    home-manager.autoUpgrade = { # Auto upgrade home-manager, unsure if this works or not
      enable = true;
      frequency = "*-*-* 20:00:00";
    };
  };

  xdg = {
    enable = true;
    desktopEntries = {
      steamGamepadUi = { # Menu entry for steam gamepad ui
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
    password-store = {
      enable = true;
      package = pkgs.pass-wayland;
    };
    bash = {
      enable = true;
      historyFile = "~/.cache/bash_history";
    };
    micro = {
      enable = true;
      settings = {
        clipboard = "terminal";
        mkparents = true;
        scrollbar = true;
        tabstospaces = true;
        tabsize = 2;
      };
    };
    fish = {
      enable = true;
      interactiveShellInit = "any-nix-shell fish --info-right | source";
      loginShellInit = "any-nix-shell fish --info-right | source";
      shellAliases = {
        d = "kitty +kitten diff";
        nano = "micro";
        wget = "wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";
        ssh = "kitty +kitten ssh";
      };
      functions = {
        fish_greeting = ''
          set -x PF_INFO ascii title os kernel uptime wm memory palette
          eval $HOME/.scripts/pfetch
        '';
        tsh = "ssh -o RequestTTY=yes $argv tmux -u -CC new -A -s tmux-main";
        pacin = "nix-env -iA nixos.$argv";
        pacre = "nix-env -e $argv";
        trizen = "nix search nixpkgs $argv";
        rebuild = "sudo nixos-rebuild switch";
        upgrade = "sudo nixos-rebuild switch --upgrade";
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
    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark.theme";
        theme_background = false;
        proc_sorting = "cpu direct";
        update_ms = 500;
      };
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
        clipboard_control = "write-clipboard read-clipboard write-primary read-primary";
        confirm_os_window_close = "-2";
        cursor_shape = "block";
        initial_window_height = "570";
        initial_window_width = "120c";
        remember_window_size = "no";
        tab_bar_background = "#3b3b3b";
        tab_bar_margin_color = "#3b3b3b";
        tab_bar_margin_height = "3 3";
        tab_bar_margin_width = 2;
        tab_bar_min_tabs = 1;
        tab_bar_style = "fade";
        tab_fade = 0;
        tab_switch_strategy = "left";
        tab_title_template = "{fmt.bg._3b3b3b}{fmt.fg._202020}{fmt.fg.default}{fmt.bg._202020}{fmt.fg._c6c6c6} {title} {fmt.fg.default}{fmt.bg.default}{fmt.fg._202020}{fmt.fg.default}";
        active_tab_title_template = "{fmt.bg._3b3b3b}{fmt.fg._fcfcfc}{fmt.fg.default}{fmt.bg._fcfcfc}{fmt.fg._3b3b3b} {title} {fmt.fg.default}{fmt.bg.default}{fmt.fg._fcfcfc}{fmt.fg.default}";
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
