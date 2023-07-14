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
        gitMobScript = with pkgs;
          substituteAll {
            src = ./src/git-mob;
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
              install -Dm755 ${gitMobScript} $out/bin/git-mob
              ln -s $out/bin/git-mob $out/bin/git-solo
              install -Dm755 ${gitMobPrintScript} $out/bin/git-mob-print
            '';
          }
        );
      in {
        apps.default = flake-utils.lib.mkApp {drv = gitMob;};
        packages.default = gitMob;
        devShells.default = pkgs.mkShell {
          packages = [gitMob];
        };
      }
    );
}
