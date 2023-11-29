{ stdenvNoCC
, dialog
, git
, jq
, lib
, makeWrapper
, shellcheck
, version
}:

let
  runtimeInputs = [ dialog git jq ];
in

stdenvNoCC.mkDerivation {
  inherit version;
  pname = "git-mob";
  src = ./.;

  GIT_MOB_COAUTHORS = "git-coauthors";
  GIT_MOB_TEMPLATE = "gitmessage.txt";
  GIT_MOB_LIST = "git-mob-list";

  nativeBuildInputs = [ makeWrapper ];

  doInstallCheck = true;
  preInstallCheck = "patchShebangs src/*";
  installCheckInputs = runtimeInputs ++ [ shellcheck ];

  postFixup = ''
    for file in $out/bin/*
    do
      wrapProgram \
        $file \
        --set PATH "${lib.makeBinPath runtimeInputs}:$out/bin:$PATH"
    done
  '';
}
