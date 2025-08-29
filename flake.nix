{
  description = "Typst Dev Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Development Packages
      dev-pkgs = [
        pkgs.typst    # Core typst package
        pkgs.tinymist # Typst LSP
        pkgs.typstyle # Typst Formatter

        pkgs.gnumake
        pkgs.coreutils
        pkgs.findutils
      ];

    in {
      # Development Shell
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = dev-pkgs;
        shellHook = ''
          echo "Typst dev environment ready"
          typst --version
          tinymist -V
          echo "typstyle $(typstyle --version | grep Version | tr -s ' ')"

          unset SOURCE_DATE_EPOCH
          export TYPST_ROOT=$(realpath .)
          '';
      };

      # Develoment Docker Image for CI/CD
      packages.${system} = {
        devImage = pkgs.dockerTools.buildLayeredImage {
          name = "typst-dev";
          tag = "latest";

          # The dev-pkgs list goes directly into the 'contents' attribute.
          # This replaces the entire 'copyToRoot' and 'buildEnv' block.
          contents = dev-pkgs ++ [ pkgs.bash ];

          # The config block remains exactly the same.
          config = {
            Cmd = ["bash"];
            WorkingDir = "/app";
          };
        };
      };
    };
}
