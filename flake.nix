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

        generateDialogArgs = pkgs.callPackage ./src/git-mob-generate-dialog-args.nix { };
        mob = pkgs.callPackage ./src/git-mob.nix { };
        print = pkgs.callPackage ./src/git-mob-print.nix { };
        solo = pkgs.callPackage ./src/git-solo.nix { };
        write = pkgs.callPackage ./src/git-mob-write.nix { };

        gitMob = pkgs.stdenv.mkDerivation {
          name = "git-mob";
          src = ./.;
          installPhase = ''
            install -Dm755 ${generateDialogArgs}/bin/* $out/bin/git-mob-generate-dialog-args
            install -Dm755 ${mob}/bin/* $out/bin/git-mob
            install -Dm755 ${print}/bin/* $out/bin/git-mob-print
            install -Dm755 ${solo}/bin/* $out/bin/git-solo
            install -Dm755 ${write}/bin/* $out/bin/git-mob-write
          '';
          doInstallCheck = true;
          installCheckPhase = ''
            export PATH="$PATH:$out/bin"
            export GIT_MOB_COAUTHORS=git-coauthors
            export GIT_MOB_TEMPLATE=gitmessage.txt
            export GIT_MOB_LIST=git-mob-list
            patchShebangs test/git-mob-tests
            patchShebangs test/git-mob-generate-dialog-args-tests
            test/git-mob-tests
            test/git-mob-generate-dialog-args-tests
          '';
        };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        apps.default = flake-utils.lib.mkApp { drv = gitMob; };
        packages.default = gitMob;
        devShells.default = pkgs.mkShell {
          packages = [
            gitMob
            pkgs.nixpkgs-fmt
          ];
        };
      });
}
