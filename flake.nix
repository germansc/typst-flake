{
  description = "Typst project template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

      devPkgs = pkgs: with pkgs; [
        typst tinymist typstyle
        gnumake coreutils findutils
      ];

    in {
      templates.default = {
        path = ./.;
        description = "Typst document project powered by Nix";
      };

      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          default = pkgs.stdenv.mkDerivation {
            name = "typst-documents";
            src = ./.;
            buildInputs = [ pkgs.typst ];
            buildPhase = ''
              mkdir -p $out
              for f in *.typ; do
                echo "Compiling $f..."
                typst compile "$f" "$out/$(basename "$f" .typ).pdf"
              done
            '';
            installPhase = "true";
          };
        }
      );

      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          default = pkgs.mkShell {
            buildInputs = devPkgs pkgs;
            shellHook = ''
              echo "Typst dev environment ready"
              typst --version
              tinymist -V
              echo "typstyle $(typstyle --version | grep Version | tr -s ' ')"

              unset SOURCE_DATE_EPOCH
              export TYPST_ROOT=$(realpath .)
            '';
          };
        }
      );
    };
}
