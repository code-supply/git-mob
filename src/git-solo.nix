{ writeShellApplication
, write
}:
writeShellApplication {
  name = "git-solo";
  runtimeInputs = [ write ];
  text = builtins.readFile ./git-solo;
}
