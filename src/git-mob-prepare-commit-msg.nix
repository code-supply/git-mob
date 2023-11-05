{ writeShellApplication
, git
, print
}:
writeShellApplication {
  name = "git-mob-prepare-commit-msg";
  runtimeInputs = [ git print ];
  text = builtins.readFile ./git-mob-prepare-commit-msg;
}
