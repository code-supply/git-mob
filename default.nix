{ symlinkJoin
, generateDialogArgs
, mob
, prepareCommitMsg
, print
, solo
, write
}:
symlinkJoin {
  name = "git-mob";
  paths = [
    generateDialogArgs
    mob
    prepareCommitMsg
    print
    solo
    write
  ];
}
