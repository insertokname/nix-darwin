{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util, nix-homebrew }:
    let
      configuration = { pkgs, config, ... }: {
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

        homebrew = {
          enable = true;
          casks = [ "karabiner-elements" "flutter" ];
        };

        fonts.packages = [
          pkgs.nerd-fonts.shure-tech-mono
          pkgs.nerd-fonts.jetbrains-mono
          #(pkgs.nerdfonts.override { fonts = ["JetBrainsMono" ];})
        ];

        #user env
        environment.variables = { EDITOR = "${pkgs.neovim}/bin/nvim"; };

        users.knownUsers = [ "insertokname" ];
        users.users.insertokname.uid = 501;
        users.users.insertokname.shell = pkgs.fish;
        programs.fish.enable = true;

        #nix crap
        nix.settings.experimental-features = "nix-command flakes";

        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.stateVersion = 5;

        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in {
      darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
        modules = [
          mac-app-util.darwinModules.default
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "insertokname";
            };
          }
        ];
      };
    };
}
