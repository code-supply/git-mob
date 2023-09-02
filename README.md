# git-mob in bash and jq, for nix.

## Why

The regular git-mob implementations have the following problems for nix users:

- They modify the global git config and use it as a database. Nix Home Manager,
  for example, allows you to configure the global git config in nix, but this
  makes it read-only.
- At least one of them is written for Node. NPM packages are irritating to
  write derivations for, due to the impure nature of the builds.
- There's no nix derivation written for those implementations AFAIK.

By default you set your team in `~/.git-coauthors`. The tool keeps state in `~/.git-mob`.
The tool's main job is to write to `~/.gitmessage.txt`.

You can override these files using environment variables:

- GIT_MOB_COAUTHORS: the JSON file where you define your team
- GIT_MOB_LIST: the state that this tool keeps
- GIT_MOB_TEMPLATE: the commit template that is written

## Installation / usage

- Enable flakes in nix.
- Configure your git to use ~/.gitmessage.txt as its commit.template. In Home
  Manager, this is `programs.git.extraConfig.commit.template`.
- Install the packages into your Home Manager
- Run `git mob ab bc` or `git solo` to work alone

Alternatively, run directly:

nix run github:code-supply/git-mob ab bc cd

It'll give you an ugly error if you don't have ~/.git-coauthors. Make that file
by hand, because I haven't written the bits to do it yet.

## See also

- [The Node one](https://github.com/rkotze/git-mob)
- [A Rust one](https://github.com/Mubashwer/git-mob)
- [Another Rust one](https://github.com/Frost/git-mob)
- [Yet Another Rust one](https://github.com/jplsek/git-mob-rs)
