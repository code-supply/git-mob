{ stdenv
, gitMob
}:
stdenv.mkDerivation {
  name = "check";
  src = ./.;
  buildInputs = [ gitMob ];
  buildPhase = ''
    export GIT_MOB_COAUTHORS=git-coauthors
    export GIT_MOB_TEMPLATE=gitmessage.txt
    export GIT_MOB_LIST=git-mob-list

    patchShebangs test/git-mob-tests
    patchShebangs test/git-mob-generate-dialog-args-tests
    patchShebangs test/git-mob-prepare-commit-msg-tests

    test/git-mob-tests
    test/git-mob-generate-dialog-args-tests
    test/git-mob-prepare-commit-msg-tests

    mkdir $out
  '';
}
