# Curated development inventory

Source snapshot: `mac23392`, Apple Silicon, macOS 15.7.3, audited
2026-07-28.

This is a curated development environment, not a byte-for-byte machine clone.

## Included

- Apple/iOS: Xcode, CocoaPods, Fastlane, SwiftFormat, SwiftLint, XcodeGen
- JavaScript/TypeScript: Node 24, pnpm, Bun, Deno, frontend editor extensions
- Other runtimes: Python 3.13, pipx, uv, Go, Rust, .NET SDK 9
- Cloud/infrastructure: AWS CLI, Google Cloud CLI, Terraform, kubectl
- Data/API tooling: Redis, libSQL/sqld, Turso, Supabase, Stripe, Resend,
  Postman, ngrok
- Editors and terminals: Cursor, Ghostty, cmux, GitHub Desktop
- Containers: OrbStack
- Browsers: Arc and Google Chrome
- Workflow utilities: Ice, Raycast, Rectangle, SwiftBar, VoiceInk
- AI development: Claude, ChatGPT, CodexBar, T3 Code, LangGraph Studio,
  Codex CLI, OpenCode, pi coding tools
- Shell/DX: Zsh, Oh My Zsh, fzf, Git, Git LFS, delta, ripgrep, bat, eza,
  zoxide, direnv, tmux, jq, yq, shellcheck, Nix tooling
- Developer fonts and the source Mac's Cursor/Ghostty preferences

## Explicitly excluded

### Security, identity, and administration

- Admin By Request
- Bitwarden data or vault configuration
- Company Portal
- GlobalProtect
- Microsoft Defender
- NoMAD
- Self Service
- Support agents
- TeamViewer Host
- AWS SSO helper configuration
- Auth0 administrative CLI configuration
- Certificates, keychains, local certificate authorities, SSH keys, GPG keys

`mkcert` itself is included because it is a local development tool, but no
certificate authority or generated certificate is copied.

### Work communication and business applications

- Microsoft Office, Outlook, Teams, OneDrive
- Slack
- Notion
- Zoom

### Personal applications and data

- Media, messaging, reminder, voice, and personal productivity applications
- Browser profiles, history, cookies, and saved passwords
- Application accounts, sessions, and telemetry identifiers

### Files and credentials

- Source repositories and work documents
- `.ssh`, cloud credentials, GitHub tokens, npm tokens, API keys
- `~/.config/gh/hosts.yml`
- Auth0, Resend, Stripe, Supabase, Turso, ngrok, AWS, and Google credentials
- Cursor workspace history, extension state, and chat history
- Shell history
- The locally installed, unpublished `pr-summary@0.1.0` npm package

Authentication must be performed manually on the target Mac.
