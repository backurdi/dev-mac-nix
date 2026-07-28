#!/usr/bin/env bash
set -euo pipefail

homebrew_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"
npm_bin="${homebrew_prefix}/opt/node@24/bin/npm"
bun_bin="${homebrew_prefix}/bin/bun"
pipx_bin="${homebrew_prefix}/bin/pipx"
npm_prefix="${HOME}/.local/share/npm"

for required in "${npm_bin}" "${bun_bin}" "${pipx_bin}"; do
  if [[ ! -x "${required}" ]]; then
    echo "Missing ${required}. Apply the nix-darwin configuration first." >&2
    exit 1
  fi
done

npm_packages=(
  "@earendil-works/pi-coding-agent@0.82.1"
  "@ifi/oh-pi-themes@0.5.1"
  "@playwright/mcp@0.0.70"
  "@tmustier/pi-files-widget@0.1.21"
  "local-ssl-proxy@2.0.5"
  "pi-annotate@0.4.3"
  "pi-web-access@0.10.7"
)

bun_packages=(
  "@openai/codex@0.145.0"
  "eas-cli@16.28.0"
  "opencode-ai@1.18.7"
)

pipx_packages=(
  "copier==9.7.1"
  "mempalace==3.1.0"
)

echo "Installing pinned npm tools into ${npm_prefix}..."
"${npm_bin}" install --global --prefix "${npm_prefix}" "${npm_packages[@]}"

echo "Installing pinned Bun tools..."
BUN_INSTALL="${HOME}/.bun" "${bun_bin}" add --global "${bun_packages[@]}"

echo "Installing pinned pipx tools..."
for package in "${pipx_packages[@]}"; do
  "${pipx_bin}" install --force "${package}"
done

echo "Global development tools are installed."
