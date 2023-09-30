{ writeShellApplication
, jq
}:
writeShellApplication {
  name = "git-mob-write";
  runtimeInputs = [ jq ];
  text = builtins.readFile ./git-mob-write;
}
