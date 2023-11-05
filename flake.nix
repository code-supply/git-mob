{
  description = "A git-mob implementation in bash and jq";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        callPackage = pkgs.lib.callPackageWith (pkgs // {
          generateDialogArgs = callPackage ./src/git-mob-generate-dialog-args.nix { };
          initials = callPackage ./src/git-mob-initials.nix { };
          mob = callPackage ./src/git-mob.nix { };
          print = callPackage ./src/git-mob-print.nix { };
          solo = callPackage ./src/git-solo.nix { };
          write = callPackage ./src/git-mob-write.nix { };
          prepareCommitMsg = callPackage ./src/git-mob-prepare-commit-msg.nix { };
        });

        gitMob = callPackage ./default.nix { };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        apps.default = flake-utils.lib.mkApp { drv = gitMob; };
        checks.default = callPackage ./check.nix { inherit gitMob; };
        packages.default = gitMob;
        devShells.default = pkgs.mkShell {
          packages = [
            gitMob
            pkgs.nixpkgs-fmt
          ];
        };
      });
}
