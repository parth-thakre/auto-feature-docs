---
name: save-feature
description: Auto-document features with git integration and versioning
agent: build
---

<!--
author: Parth Thakre
version: 1.0.0
tested-with: OpenCode 0.x
tags: [documentation, git, workflow]
license: MIT
-->

Document the feature "$1" automatically.

**Arguments:**
- $1: Feature name (optional - auto-detects from git branch if empty)
- $2: Reason/Context (optional - capture why you made key decisions)

**Quick flow:**
1. Get name from $1 or git branch (run: `git branch --show-current 2>/dev/null`)
2. Clean branch name: remove feat/, hotfix/ prefixes, convert to kebab-case
3. Create `docs/features/{kebab-name}/` if needed
4. Pick filename: `YYYY-MM-DD.md` (e.g., 2026-02-02.md) or `YYYY-MM-DD-v2.md` if exists
5. Analyze recent changes (run: `git diff --name-only HEAD~5 2>/dev/null`)
6. Write docs with real code snippets
7. Update `./FEATURES.md` index (create if missing)

**Template to fill:**
```markdown
# Feature: {Name}
**Date:** YYYY-MM-DD | **Version:** v1 | **Author:** {git config user.name || "—"}

## Overview
{What it does and why}

## Implementation
### Files Changed
- `path/to/file.ts` - {changes}

### Rationale
{Why you made key decisions - from $2 or auto-detected from code}

### Code Examples
```typescript
// Actual usage code from your implementation
```

## Testing
- Test files: `path/to/test.ts` or "None"
- Coverage: {what's tested}
- Notes: N/A if no tests / TODO if planned

## Dependencies
### Added
- `{package}@{version}` - {purpose}

## Breaking Changes
{List or "None - initial"}

## Notes
- {Known issues}
- {TODOs}
```

**FEATURES.md entry:**
```markdown
| Date | Feature | Version | Description | Author | Link |
|------|---------|---------|-------------|--------|------|
| 2025-02-02 | {Name} | v1 | {60 char max} | {Author} | [View](docs/features/{folder}/{file}) |
```

**Edge cases:**
- No git repo → prompt for name
- No docs/features/ → auto-create
- Same day save → auto-v2, v3...
- No changes → warn before creating

**Your task:** Execute this flow for "$1". If "$2" (reason) is provided, include it in the Rationale section. Otherwise, infer key decisions from the code changes. Use current context to understand what was built and generate accurate docs.
