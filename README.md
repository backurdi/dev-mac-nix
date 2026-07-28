# Development Mac with Nix

A development-only, Git-friendly macOS configuration generated from
`mac23392` on 2026-07-28.

It uses:

- nix-darwin for macOS and Homebrew declarations
- nix-homebrew for the Homebrew installation
- Home Manager for shell tools and safe dotfiles
- Homebrew for macOS applications, SDKs, and niche development CLIs

See `INVENTORY.md` for the complete inclusion and exclusion policy.

## Safety properties

- Homebrew activation is additive: it never removes unlisted applications.
- No company security, MDM, VPN, support, or administrative software is
  declared.
- No tokens, keys, sessions, browser profiles, histories, certificates, or
  work files are included.
- Existing Home Manager targets are backed up with the `.hm-backup` suffix.
- The bootstrap does not install Nix implicitly and does not run on Intel Macs.

## Before the first run

1. Use an Apple Silicon Mac.
2. Review and, if necessary, edit `user.nix`.
3. Sign in to the Mac App Store if `installXcode = true`.
4. Install Nix or Lix. nix-darwin currently recommends Lix because its
   installer includes an automated uninstaller:
   <https://lix.systems/install/>
5. Clone this repository to the target Mac.

## Pin and validate without applying

```bash
nix --extra-experimental-features "nix-command flakes" flake lock
nix --extra-experimental-features "nix-command flakes" flake check
nix --extra-experimental-features "nix-command flakes" \
  eval --raw \
  .#darwinConfigurations.dev-mac.config.system.build.toplevel.drvPath
```

All inputs in `flake.nix` already reference exact upstream commits. The lock
command adds NAR content hashes. On the source work Mac, the local Nix cache
was unusually slow to import Nixpkgs, so the generated folder intentionally
does not contain a partial lockfile.

## Apply

```bash
./bootstrap.sh
```

The bootstrap repeats all three validation commands before applying anything.
The initial run then installs Homebrew, development applications, Xcode, shell
tools, Cursor extensions, safe dotfiles, and pinned user-level CLI tools.
It can take a while, particularly the Xcode download.

If you do not want Xcode, set `installXcode = false` in `user.nix`.

## Authenticate after installation

Credentials are intentionally not migrated. Run only the commands you need:

```bash
gh auth login
aws configure sso
gcloud auth login
stripe login
supabase login
turso auth login
ngrok config add-authtoken
```

Also open Cursor, Claude, ChatGPT, Postman, and any other account-based
application and sign in normally.

For Xcode, accept the license and select the installed developer directory:

```bash
sudo xcodebuild -license
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

## Update

Update pinned Nix inputs, review the diff, then apply:

```bash
nix flake update
nix flake check
sudo darwin-rebuild switch --flake .#dev-mac
```

The versions in `scripts/install-global-tools.sh` are intentionally pinned.
Update them manually when you want newer global npm, Bun, or pipx tools.

## Put it on GitHub

Generate and commit `flake.lock` before pushing. It adds content hashes on top
of the immutable input commits already declared in `flake.nix`.

```bash
git init
git add .
git commit -m "Add development Mac configuration"
git branch -M main
git remote add origin YOUR_GITHUB_REPOSITORY
git push -u origin main
```
