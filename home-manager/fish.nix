{ ... }: {
  programs.fish = {
    enable = true;
    functions = { fish_greeting = { body = ""; }; };
    shellAliases = {
      gf = "git fetch";
      gs = "git status";
      ga = "git add .";
      gc = "git commit -m";
      gp = "git push";
    };
  };
}