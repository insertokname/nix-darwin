{...}: {
  imports = [
    ./aerospace.nix
    ./fish.nix
  ];

  programs.home-manager.enable = true;

  home.sessionPath = [
    "/opt/homebrew/bin/"
  ];

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}