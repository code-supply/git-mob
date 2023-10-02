{ writeShellApplication
, dialog
, print
, initials
}:
writeShellApplication {
  name = "git-mob";
  runtimeInputs = [ dialog print initials ];
  text = builtins.readFile ./git-mob;
}
