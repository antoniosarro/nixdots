{
  programs.zsh = {
    enable = true;

    # relative to ~
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;

    history = {
      size = 10000;
      share = true;
      ignoreAllDups = true;
    };

    shellAliases = {
      # Overrides those provided by OMZ libs, plugins, and themes.
      # For a full list of active aliases, run `alias`.

      #-------------Bat related------------
      cat = "bat";
      diff = "batdiff";
      rg = "batgrep";
      man = "batman";

      #------------Navigation------------
      doc = "cd $HOME/documents";
      scripts = "cd $HOME/scripts";
      ts = "cd $HOME/.talon/user/fidget";
      src = "cd $HOME/src";
      edu = "cd $HOME/src/edu";
      dfs = "cd $HOME/src/dotfiles";
      dfsw = "cd $HOME/src/dotfiles.wiki";
      nfs = "cd $HOME/nix-config";
      uc = "cd $HOME/src/unmovedcentre";
      l = "eza -lah";
      la = "eza -lah";
      ll = "eza -lh";
      ls = "eza";
      lsa = "eza -lah";

      #-------------Neovim---------------
      e = "nvim";
      vi = "nvim";
      vim = "nvim";

      #-----------Nix related----------------
      nfc = "nix flake check";
      ne = "nix instantiate --eval";
      nb = "nix build";
      ns = "nix shell";

      #-------------Git Goodness-------------
      # just reference `$ alias` and use the defautls, they're good.
    };
  };
}
