{config, pkgs, ...}:
{

  home.packages = with pkgs; [
    ripgrep
    fzf
    # Alternative to find
    fd
  ];

  programs.neovim = 
  let 
   # toLua = str: "lua << EOF\n${str}\nEOF\n";
   toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
	# visual
    nvim-web-devicons
	nord-nvim

    # telescope setup
    plenary-nvim
    {
      plugin = telescope-nvim;
      config = toLuaFile ./plugin/telescope.lua;
    }
    telescope-fzf-native-nvim

	# which-key setup
	which-key-nvim

	# autopairs setup
	{
	  plugin = nvim-autopairs;
	  config = toLuaFile ./plugin/autopairs.lua;
	}
	
	# treesitter setup
	(nvim-treesitter.withPlugins (p : [p.c p.python p.cmake p.cpp p.lua p.nix p.vhdl]))

	# autocomplete setup
	cmp-nvim-lsp
	cmp-buffer
	cmp-path
	cmp-cmdline
	{
	  plugin = nvim-cmp;
	  config = toLuaFile ./plugin/cmp.lua;
	}

	luasnip

    ];

    extraConfig = "${toLuaFile ./options.lua}";
    extraPackages = with pkgs; [
     xclip
     wl-clipboard

	 # External language servers
     pyright
	 ltex-ls
     clang-tools
	 nil
	 vhdl-ls
    ];
  };

}
