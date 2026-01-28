{
  description = "Flake for LTAisle development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      packages.fhs = pkgs.buildFHSEnv {
        name = "fhs-shell";
        targetPkgs = pkgs: [
          pkgs.python313
          pkgs.python313Packages.uv
        ];
      };
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [
          packages.fhs
        ];
      };
    in {
      inherit devShells;
      inherit packages;
    });
}
