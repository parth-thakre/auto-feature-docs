# OpenCode Commands

Commands formatted for OpenCode.

## Available

| Command | Description | File |
|---------|-------------|------|
| `/save-feature` | Auto-document features | [save-feature.md](save-feature.md) |

## Install

**Quick:**
```bash
curl -o .opencode/commands/save-feature.md \
  https://raw.githubusercontent.com/yourname/ai-dev-commands/main/commands/opencode/save-feature.md
```

**With script:**
```bash
./install.sh opencode
```

## OpenCode Syntax

**Shell:** `` `!`git branch --show-current`` ``

**Files:** `@src/main.ts`

**Agent:** Add `agent: code` to frontmatter

## Differences from Claude Code

| | OpenCode | Claude Code |
|--|----------|-------------|
| Shell | `` `!`cmd`` `` | "Use bash tool" |
| Files | `@file` | Mention it |
| Agent | Required | Not used |

## Testing

Test in OpenCode before submitting PRs.
