{ writeShellApplication
}:
writeShellApplication {
  name = "git-solo";
  runtimeInputs = [ ];
  text = builtins.readFile ./git-solo;
}
