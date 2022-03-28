{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        packages = {
          cbonsai = pkgs.stdenv.mkDerivation {
            name = "cbonsai";
            src = pkgs.fetchFromGitLab {
              owner = "jallbrit";
              repo = "cbonsai";
              rev = "b3ee97a0";
              sha256 = "8JwwrTS8pOLwNYsnBGwqazGrTbts7LADndEdTit6Kc0=";
            };
            nativeBuildInputs = with pkgs; [ gcc gnumake pkg-config ];
            buildInputs = with pkgs; [ ncurses ];
            installPhase = ''
              make install PREFIX=$out
            '';
          };
        };
      in rec {
        devShell = pkgs.mkShell {
          buildInputs = [ packages.cbonsai ];
        };
        defaultPackage = packages.cbonsai;
      });
}

