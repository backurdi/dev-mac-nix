#!/usr/bin/env bash
set -euo pipefail

config_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(uname -m)" != "arm64" ]]; then
  echo "This configuration targets Apple Silicon (arm64)." >&2
  echo "Edit user.nix and review the Homebrew settings for an Intel Mac." >&2
  exit 1
fi

if ! command -v nix >/dev/null 2>&1; then
  echo "Nix or Lix is required before running this bootstrap." >&2
  echo "See README.md for the upstream installation link." >&2
  exit 1
fi

nix_bin="$(command -v nix)"

echo "Pinning and validating the flake..."
"${nix_bin}" \
  --extra-experimental-features "nix-command flakes" \
  flake lock "${config_dir}"
"${nix_bin}" \
  --extra-experimental-features "nix-command flakes" \
  flake check --no-build "${config_dir}"
"${nix_bin}" \
  --extra-experimental-features "nix-command flakes" \
  eval --raw \
  "${config_dir}#darwinConfigurations.dev-mac.config.system.build.toplevel.drvPath" \
  >/dev/null

echo "Evaluating and applying the development Mac configuration..."
sudo "${nix_bin}" \
  --extra-experimental-features "nix-command flakes" \
  run github:nix-darwin/nix-darwin/c3e90c89649b07d1a96e4b9dd6cd0d6e44b91a74#darwin-rebuild \
  -- switch --flake "${config_dir}#dev-mac"

echo "Installing pinned user-level development tools..."
"${config_dir}/scripts/install-global-tools.sh"

echo
echo "Development Mac setup complete."
echo "Open a new terminal, then follow the authentication checklist in README.md."
