# Claude Code Commands

Commands formatted for Claude Code.

## Available

| Command | Description | File |
|---------|-------------|------|
| `/save-feature` | Auto-document features | [save-feature.md](save-feature.md) |

## Install

**Quick:**
```bash
curl -o .claude/commands/save-feature.md \
  https://raw.githubusercontent.com/yourname/ai-dev-commands/main/commands/claude-code/save-feature.md
```

**With script:**
```bash
./install.sh claude-code
```

## Claude Code Syntax

**Shell:** "Use bash tool: `git branch --show-current`"

**Files:** Mention them or use file reading tool

**Agent:** Not used in frontmatter

## Differences from OpenCode

| | Claude Code | OpenCode |
|--|-------------|----------|
| Shell | "Use bash tool" | `` `!`cmd`` `` |
| Files | Mention it | `@file` |
| Agent | Not used | Required |

## Testing

Test in Claude Code before submitting PRs.
