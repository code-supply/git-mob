{ stdenv
, generateDialogArgs
, mob
, print
, solo
, write
}:
stdenv.mkDerivation
{
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
}

