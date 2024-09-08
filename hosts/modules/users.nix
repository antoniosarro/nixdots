{
  config,
  pkgs,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.${config.var.username} = {
      isNormalUser = true;
      description = "${config.var.username} account";
      hashedPassword = "$y$j9T$fWn4.HzmsT7aryHo34PfC.$wlH3KX5.fdTztxgS8kYNCOTqD1RcebdP0S6q1Z4kT77";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
