# git-mob in bash and jq, for nix.

## Why

The regular git-mob implementations have the following problems for nix users:

- They modify the global git config and use it as a database. Nix Home Manager,
  for example, allows you to configure the global git config in nix, but this
  makes it read-only.
- At least one of them is written for Node. NPM packages are irritating to
  write derivations for, due to the impure nature of the builds.
- There's no nix derivation written

## See also

- [The Node one](https://github.com/rkotze/git-mob)
- [A Rust one](https://github.com/Mubashwer/git-mob)
- [Another Rust one](https://github.com/Frost/git-mob)
- [Yet Another Rust one](https://github.com/jplsek/git-mob-rs)
