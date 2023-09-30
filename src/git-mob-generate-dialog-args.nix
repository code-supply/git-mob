{ writeShellApplication
, jq
}:
writeShellApplication {
  name = "git-mob-generate-dialog-args";
  runtimeInputs = [ jq ];
  text = builtins.readFile ./git-mob-generate-dialog-args;
}

