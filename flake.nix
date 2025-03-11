{
  description = "A command line tool for ConTeXt projects";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        deps = with pkgs; [
          nodejs_22
        ];
      in
      {
        packages.default = pkgs.buildNpmPackage {
          name = "gutenborg";
          nativeBuildInputs = deps;
          src = self;
        };
        devShell = pkgs.mkShell {
          name = "gutenborg";
          packages = deps;
        };
      }
    );

}
