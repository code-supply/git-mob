{ writeShellApplication
, jq
}:
writeShellApplication {
  name = "git-mob-initials";
  runtimeInputs = [ jq ];
  text = builtins.readFile ./git-mob-initials;
}
