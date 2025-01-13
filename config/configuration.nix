{ pkgs, config, ... }: {
  #pkgs
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    obsidian
    iterm2
    gh
    vscode
    nixfmt
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "insertokname";
  };

  homebrew = {
    enable = true;

    casks = [
      "karabiner-elements"
      "flutter"
      "aerospace" # config for this is inside ./aerospace.nix
    ];
    taps = [
      "nikitabobko/tap" # tap for aero
    ];
  };

  fonts.packages =
    [ pkgs.nerd-fonts.shure-tech-mono pkgs.nerd-fonts.jetbrains-mono ];

  #user env
  environment.variables = { EDITOR = "${pkgs.neovim}/bin/nvim"; };

  users.knownUsers = [ "insertokname" ];
  users.users.insertokname.home = "/Users/insertokname";
  users.users.insertokname.uid = 501;
  users.users.insertokname.shell = pkgs.fish;
  programs.fish.enable = true;

  #trying to make macos usable
  system.defaults.finder = {
    AppleShowAllFiles = true;
    FXDefaultSearchScope = "SCcf";
    FXEnableExtensionChangeWarning = false;
    FXPreferredViewStyle = "Nlsv";
    QuitMenuItem = true;
    ShowPathbar = true;
    ShowStatusBar = true;
    _FXShowPosixPathInTitle = true;
    _FXSortFoldersFirst = true;
  };

  #nix crap
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
