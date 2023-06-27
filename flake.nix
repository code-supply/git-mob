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
        gitMob = with pkgs; (
          stdenv.mkDerivation
          rec {
            name = "git-mob";
            buildCommand = ''
              install -Dm755 ${gitMobScript} $out/bin/git-mob
              ln -s $out/bin/git-mob $out/bin/git-solo
              install -Dm755 ${gitMobPrintScript} $out/bin/git-mob-print
            '';
            gitMobScript = substituteAll {
              src = ./src/git-mob;
              isExecutable = true;
              jq = "${jq}/bin/jq";
            };
            gitMobPrintScript = substituteAll {
              src = ./src/git-mob-print;
              isExecutable = true;
              jq = "${jq}/bin/jq";
            };
          }
        );
      in {
        apps = {
          default = flake-utils.lib.mkApp {drv = gitMob;};
        };
      }
    );
}
