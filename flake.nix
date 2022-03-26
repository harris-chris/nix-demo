{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    mach-nix = {
      url = "github:DavHau/mach-nix";
    };
  };
  outputs = { self, nixpkgs, mach-nix }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    machNix = mach-nix.lib.x86_64-linux;

    requirements = ''
      numpy
    '';

    c_packages = with pkgs; [ gcc ];

    python_environment = machNix.mkPython {
      inherit requirements;
      packagesExtra = c_packages;
    };
  in rec {
    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = [ python_environment ];
    };
  };
}

