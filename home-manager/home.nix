{pkgs, ...}: {
  home.username = "samuel";
  home.homeDirectory = "/home/samuel";

  imports = [
    ./nvim/nvim.nix
    ./i3/i3.nix
  ];

  home.packages = with pkgs; [
    neofetch
    tree
    btop
    librewolf
    discord
    alacritty
    syncthing
    obsidian
    kicad-unstable
    ghostty
    starship
    quartus-prime-lite
    zoom-us
    parsec-bin
    bluetui
    sdcc
    p7zip
    wineWowPackages.unstable
    pandoc
    texliveFull
    gimp
    cargo
  ];

  programs.alacritty = {
    enable = true;
    theme = "hatsunemiku";
    settings = {
      window = {
        decorations = "None";
      };
      font = {
        normal.family = "DroidSansM Nerd Font Mono";
        normal.style = "Regular";
        bold.family = "DroidSansM Nerd Font Mono";
        italic.family = "DroidSansM Nerd Font Mono";
        bold_italic.family = "DroidSansM Nerd Font Mono";
        bold_italic.style = "Thin";
        size = 11.5;
      };
    };
  };

  programs.ghostty = {
    enable = true;
    installVimSyntax = true;
    settings = {
      theme = "Nord";
      font-family = "FiraCode Nerd Font Mono";
      font-style = "Regular";
      font-style-italic = "Thin";
      font-size = 11.5;
      cursor-style = "block";
      background-image = "~/.terminal_wallpaper.jpg";
      background-image-opacity = 0.1;
      background-image-fit = "cover";
      window-show-tab-bar = "never";
      window-decoration = "none";
      window-padding-x = "2";
      window-padding-y = "2";
      keybind = [
        "ctrl+h=goto_split:left"
        "ctrl+l=goto_split:right"
      ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$username $directory$git_branch$git_status$character";
      character = {
        success_symbol = "[:](green)";
        error_symbol = "[:](red)";
      };
      git_branch = {
        format = "[$branch]($style)";
      };
      git_status = {
        style = "bold cyan";
      };
      username = {
        show_always = true;
        style_user = "blue bold";
        style_root = "red bold";
        format = "[$user]($style)";
      };
      hostname = {
        ssh_only = true;
        style = "blue";
        format = "[@$hostname]($style)";
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    historyFileSize = 100000;
    historyIgnore = ["ls" "cd" "exit" "poweroff" "nvim" "reboot"];
    shellAliases = {
      gs = "git status";
      ga = "git add *";
      gc = "git commit -am";
      n = "nvim";
      ll = "ls -l";
      ".." = "cd ..";
      rebuild = "sudo nixos-rebuild switch --flake /home/samuel/nixos-config#hostname";
      a51 = "wine ~/school/cpen-312/a51.exe";
    };
  };

  home.file.".gitmessage".text = ''
    # Fill in what comes after: "This commit will..."
    # Subject line (keep it under 50 chars) ###########


    # Multi-line description goes here. ####################################
  '';

  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            name = "Samuel Sjoden";
            email = "sjodensamuel@gmail.com";
          };
          alias = {
            st = "status";
            co = "checkout";
            cm = "commit -m";
            ca = "commit --amend";
            gl = "log -n10 --oneline";
          };
          core = {
            editor = "nvim";
          };
          commit = {
            template = "~/.gitmessage";
          };
        };
      }
    ];
  };

  home.stateVersion = "25.05";
}
