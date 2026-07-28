# Validation record

Validated on 2026-07-28.

## Passed

- Every `.nix` source file parses with `nix-instantiate --parse`.
- Cursor settings and keybindings are valid JSON.
- Bootstrap and global-tool scripts pass `bash -n`.
- Both scripts have executable permissions.
- Active configuration contains none of the explicitly banned
  corporate/security/administrative application names.
- A repository-wide credential-pattern scan found no secrets.
- Every declared npm/Bun package and version exists in the public npm registry,
  except the intentionally excluded local `pr-summary` package.
- Both declared pipx package versions exist in PyPI.
- The exact nix-darwin 26.05 source contains the declared Homebrew options,
  including trusted taps, additive cleanup, VS Code/Cursor extensions, and
  Mac App Store applications.
- The exact Home Manager 26.05 source contains the declared Git, Zsh, session,
  file, direnv, fzf, zoxide, and tmux option families.
- The exact nix-homebrew source contains `autoMigrate`, `mutableTaps`,
  `enableRosetta`, and user ownership options.
- All four Nix inputs are immutable upstream commit references.

## Deferred to the target Mac

ShellCheck is declared in the target Home Manager packages but was not
installed on the source Mac, so a local ShellCheck run was not available.

A full `darwinConfigurations.dev-mac` module evaluation and `flake.lock`
generation require importing the Nixpkgs source tree. The source work Mac's
Nix 2.28 cache repeatedly spent more than ten minutes materializing that tree,
despite remaining active and error-free, so the import was stopped without
applying or building anything.

`bootstrap.sh` runs `nix flake lock`, `nix flake check --no-build`, and an
explicit evaluation of the nix-darwin system derivation before it invokes
`darwin-rebuild`. It will stop before applying the configuration if any check
fails.
