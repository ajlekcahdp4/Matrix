{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    Vector.url = "github:ajlekcahdp4/Vector";
  };
  outputs =
    {
      nixpkgs,
      flake-parts,
      treefmt-nix,
      ...
    }@inputs:
    let
      overlayMatrix = import ./nix/overlays/matrix.nix;
      composedOverlay = nixpkgs.lib.composeExtensions overlayMatrix inputs.Vector.overlays.default;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ treefmt-nix.flakeModule ];
      systems = [ "x86_64-linux" ];
      flake.overlays = {
        default = composedOverlay;
      };
      perSystem =
        { pkgs, system, ... }:
        {
          imports = [ ./nix/treefmt.nix ];
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ composedOverlay ];
          };
          packages.default = pkgs.Matrix;
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              cmake
              gdb
              valgrind
              gtest
              Vector
            ];
            buildInputs = [ ];
          };
        };
    };
}
