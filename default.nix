{ symlinkJoin
, generateDialogArgs
, mob
, print
, solo
, write
}:
symlinkJoin {
  name = "git-mob";
  paths = [
    generateDialogArgs
    mob
    print
    solo
    write
  ];
}
