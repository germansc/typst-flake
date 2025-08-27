{
  description = "Typst Dev Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # Development Shell
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.typst    # Core typst package
          pkgs.tinymist # Typst LSP
          pkgs.typstyle # Typst Formatter
          pkgs.gnumake
        ];
        shellHook = ''
          echo "Typst dev environment ready"
          typst --version
          tinymist -V
          echo "typstyle $(typstyle --version | grep Version | tr -s ' ')"

          unset SOURCE_DATE_EPOCH
          export TYPST_ROOT=$(realpath .)
        '';
      };
    };
}

