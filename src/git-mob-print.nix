{ writeShellApplication
, jq
}:
writeShellApplication {
  name = "git-mob-print";
  runtimeInputs = [ jq ];
  text = builtins.readFile ./git-mob-print;
}
