{
  imports = [
    # modern, maintained replacement for ls
    ./eza.nix
    # command-line fuzzy finder written in Go
    ./fzf.nix
    # simple terminal UI for git commands
    ./lazygit.nix
    # minimal, blazing fast, and extremely customizable prompt for any shell
    ./starship.nix
    # terminal multiplexer
    ./tmux.nix
    # fast cd command that learns your habits
    ./zoxide.nix
    # z shell
    ./zsh.nix
  ];
}
