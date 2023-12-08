{
  description = "A git-mob implementation in bash and jq";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = generate: nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ]
        (system: generate (
          let
            pkgs = nixpkgs.legacyPackages.${system};
            callPackage = pkgs.lib.callPackageWith
              (pkgs // {
                version =
                  if self ? rev
                  then self.rev
                  else "dirty";
              });
          in
          {
            inherit pkgs;
            gitMob = callPackage ./default.nix { };
          }
        ));
    in
    {
      formatter = forAllSystems ({ pkgs, ... }: pkgs.nixpkgs-fmt);
      apps = forAllSystems
        ({ gitMob }: {
          default = {
            type = "app";
            program = gitMob;
          };
        });
      packages = forAllSystems ({ gitMob, ... }: {
        default = gitMob;
      });
      devShells = forAllSystems ({ pkgs, gitMob, ... }: {
        default = pkgs.mkShell {
          packages = [
            gitMob
            pkgs.dialog
            pkgs.nixpkgs-fmt
          ];
        };
      });
    };
}
