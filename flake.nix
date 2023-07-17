{
  description = "A git-mob implementation in bash and jq";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        writeScript = with pkgs;
          substituteAll {
            src = ./src/write;
            isExecutable = true;
            jq = "${jq}/bin/jq";
          };

        gitMobPrintScript = with pkgs;
          substituteAll {
            src = ./src/git-mob-print;
            isExecutable = true;
            jq = "${jq}/bin/jq";
          };

        gitMob = with pkgs; (
          stdenv.mkDerivation
          {
            name = "git-mob";
            src = ./.;
            installPhase = ''
              install -Dm755 ${./src/git-mob} $out/bin/git-mob
              install -Dm755 ${./src/git-solo} $out/bin/git-solo
              install -Dm755 ${writeScript} $out/bin/write
              install -Dm755 ${gitMobPrintScript} $out/bin/git-mob-print
            '';
            doInstallCheck = true;
            installCheckPhase = ''
              export PATH="$PATH:$out/bin"
              export GIT_MOB_COAUTHORS=git-coauthors
              export GIT_MOB_TEMPLATE=gitmessage.txt
              export GIT_MOB_LIST=git-mob-list
              patchShebangs test/git-mob-tests
              test/git-mob-tests
            '';
          }
        );
      in {
        apps.default = flake-utils.lib.mkApp {drv = gitMob;};
        packages.default = gitMob;
        devShells.default = pkgs.mkShell {
          packages = [
            gitMob
            pkgs.shellcheck
          ];
        };
      }
    );
}
