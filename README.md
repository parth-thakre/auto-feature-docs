# AI Dev Commands

Slash commands that actually help you document what you build. Works with OpenCode and Claude Code.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue)](https://claude.ai/code)
[![OpenCode](https://img.shields.io/badge/OpenCode-Compatible-green)](https://opencode.ai)

## Why?

Because "I'll document it later" never happens, and trying to remember what you built 3 months ago is painful.

## Quick Start

**OpenCode:**
```bash
curl -o .opencode/commands/save-feature.md \
  https://raw.githubusercontent.com/parth-thakre/auto-feature-docs/main/commands/opencode/save-feature.md
```

**Claude Code:**
```bash
curl -o .claude/commands/save-feature.md \
  https://raw.githubusercontent.com/parth-thakre/auto-feature-docs/main/commands/claude-code/save-feature.md
```

**Or use the installer:**
```bash
git clone https://github.com/parth-thakre/auto-feature-docs.git
cd auto-feature-docs
./install.sh opencode  # or claude-code
```

## Available Commands

| Command | Description | Tools |
|---------|-------------|-------|
| `/save-feature` | Auto-generates versioned feature docs with git integration | Claude, OpenCode |

## How It Works

```bash
# Auto-detects from git branch (e.g., feat/user-auth → "user-auth")
/save-feature

# Or specify directly
/save-feature "User Authentication"

# With decision context (captures the "why")
/save-feature "Payment Retry" "switched from exponential to linear backoff due to rate limits"
```

**Creates:**
```
project-root/
├── FEATURES.md                    # Auto-updated index
└── docs/
    └── features/
        └── user-authentication/
            ├── 2025-02-02.md      # Initial
            └── 2025-02-02-v2.md   # Same-day update
```

**Features:**
- ✅ Git branch auto-detection
- ✅ Versioned entries (v2, v3 for same-day updates)
- ✅ Real code snippets (not placeholders)
- ✅ Auto-updated index
- ✅ Handles edge cases gracefully

## Tool Support

| Tool | Status | Command Directory |
|------|--------|-------------------|
| OpenCode | ✅ Full | `.opencode/commands/` |
| Claude Code | ✅ Full | `.claude/commands/` |

## Project Structure

```
auto-feature-docs/
├── commands/
│   ├── claude-code/          # Claude Code variants
│   └── opencode/             # OpenCode variants
├── templates/                # Doc templates
├── install.sh               # Auto-installer
├── README.md
└── LICENSE
```

## Contributing

PRs welcome. Fork it, add your command, test it, send it over.

## License

MIT - see [LICENSE](LICENSE)

---

Built because documentation shouldn't be a chore.
