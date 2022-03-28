{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        c_packages = with pkgs; [ gcc ];

        cbonsai = pkgs.stdenv.mkDerivation {
          name = "cbonsai";
          src = pkgs.fetchurl "https://gitlab.com/jallbrit/cbonsai";
          sha256 = "01bf6kh1fxxbhy7vijajpx30q9iqdsqqi74wvpc0j86w28w0af4q";
        };
      in rec {
        devShell = pkgs.mkShell {
          buildInputs = [ cbonsai ];
        };
      });
}

