{
  description = "Personal development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Ghostty (if available via nix - otherwise installed separately)
    # ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      # Supported systems
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      homeConfigurations = {
        # macOS Apple Silicon (default)
        "jamescomputer" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home.nix ];
        };

        # macOS Intel
        "jamescomputer-intel" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home.nix ];
        };

        # Linux
        "jamescomputer-linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home.nix ];
        };
      };

      # Development shell for working on dotfiles
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            packages = [ home-manager.packages.${system}.default ];
          };
        });
    };
}
