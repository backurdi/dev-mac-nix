{ lib, user, ... }:

{
  homebrew = {
    enable = true;
    user = user.username;
    enableZshIntegration = true;

    # Intentionally additive. This prevents activation from removing
    # company-managed or unrelated software on any Mac.
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };

    taps = map
      (name: {
        inherit name;
        trusted = true;
      })
      [
        "agavra/tap"
        "hashicorp/tap"
        "libsql/sqld"
        "oven-sh/bun"
        "resend/cli"
        "stripe/stripe-cli"
        "supabase/tap"
        "tursodatabase/tap"
      ];

    # macOS- or toolchain-specific CLI software. Portable shell utilities are
    # managed by Home Manager instead.
    brews = [
      "act"
      "agent-browser"
      "awscli"
      "cocoapods"
      "deno"
      "fastlane"
      "ffmpeg"
      "fswatch"
      "go"
      "kubernetes-cli"
      "langgraph-cli"
      "mkcert"
      "node@24"
      "pipx"
      "pnpm"
      "poppler"
      "python@3.13"
      "redis"
      "rust"
      "swiftformat"
      "swiftlint"
      "uv"
      "whisper-cpp"
      "xcodegen"

      "agavra/tap/tuicr"
      "hashicorp/tap/terraform"
      "libsql/sqld/sqld"
      "oven-sh/bun/bun"
      "resend/cli/resend"
      "stripe/stripe-cli/stripe"
      "supabase/tap/supabase"
      "tursodatabase/tap/turso"
    ];

    casks = [
      # Editors, terminals, browsers, and developer workflow
      "arc"
      "cursor"
      "ghostty"
      "cmux"
      "github"
      "google-chrome"
      "orbstack"
      "postman"

      # Credentials, window, menu-bar, capture, and voice workflow utilities
      "bitwarden"
      "jordanbaird-ice"
      "raycast"
      "rectangle"
      "shottr"
      "swiftbar"
      "voiceink"

      # AI development tools currently used on the source Mac
      "chatgpt"
      "claude"
      "codexbar"
      "langgraph-studio"
      "t3-code"

      # SDKs, cloud tooling, local tunnels, and menu-bar scripting
      "dotnet-sdk@9"
      "gcloud-cli"
      "ngrok"

      # Developer fonts
      "font-fira-code-nerd-font"
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
    ];

    masApps = lib.optionalAttrs user.installXcode {
      Xcode = 497799835;
    };

    # Homebrew Bundle installs these into Cursor when Cursor is available.
    # Authentication- and company-specific extensions were intentionally
    # omitted.
    vscode = [
      "anysphere.remote-containers"
      "anysphere.remote-ssh"
      "astro-build.astro-vscode"
      "bradlc.vscode-tailwindcss"
      "coderabbit.coderabbit-vscode"
      "dbaeumer.vscode-eslint"
      "esbenp.prettier-vscode"
      "formulahendry.github-actions"
      "github.vscode-github-actions"
      "github.vscode-pull-request-github"
      "golang.go"
      "hashicorp.terraform"
      "johnpapa.vscode-peacock"
      "me-dutour-mathieu.vscode-github-actions"
      "ms-dotnettools.csdevkit"
      "ms-dotnettools.csharp"
      "ms-dotnettools.vscode-dotnet-runtime"
      "ms-vscode.makefile-tools"
      "oxc.oxc-vscode"
      "redhat.vscode-yaml"
      "sissel.shopify-liquid"
      "solomonkinard.git-blame"
      "unifiedjs.vscode-mdx"
      "yamachu.workflow-script-highlighter"
      "yoavbls.pretty-ts-errors"
      "yseop.vscode-yseopml"
    ];
  };
}
