{ writeShellApplication
, dialog
}:
writeShellApplication {
  name = "git-mob";
  runtimeInputs = [ dialog ];
  text = builtins.readFile ./git-mob;
}
