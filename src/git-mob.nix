{ writeShellApplication
, dialog
, initials
, print
, write
}:
writeShellApplication {
  name = "git-mob";
  runtimeInputs = [
    dialog
    initials
    print
    write
  ];
  text = builtins.readFile ./git-mob;
}
