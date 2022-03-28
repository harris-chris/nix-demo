{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    mach-nix = { url = "github:DavHau/mach-nix"; };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, mach-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        machNix = mach-nix.lib."${system}";
        requirements = ''
          numpy
        '';

        env = machNix.mkPython {
          inherit requirements;
        };

      in {
        devShell = pkgs.mkShell {
          buildInputs = [ env ];
        };
      });
}

