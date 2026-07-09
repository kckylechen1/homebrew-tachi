# Homebrew Tap for Tachi

Public **binary** distribution surface for Tachi (#874).

This repository is intentionally not the source of truth for Tachi product
requirements, capability metadata, agent instructions, skills, plugins, MCP
bundles, or source code. The authoritative source repository, issue tracker, and
review workflow are maintainer-controlled and private.

## Install

```bash
brew tap kckylechen1/tachi
brew install tachi
```

Current public binaries: **macOS arm64** (Apple Silicon). Intel macOS is not
published yet.

After upgrade, verify the **running** binary / daemon identity:

```bash
tachi --version
tachi status   # runtime.build.git_sha / runtime.binary
```

## What this tap may contain

- Formula files under `Formula/`
- release artifacts (prebuilt `tachi` binaries) and checksums
- bottle metadata when present
- install notes

It must not contain source code, product planning, capability authority, agent
runtime state, or issue-driven support workflow.

## Promotion path

1. Cut and verify a private Tachi source release (`kckylechen1/tachi` tag `vX.Y.Z`).
2. Attach reviewed platform binaries (`tachi-vX.Y.Z-<triple>.tar.gz`).
3. Run `scripts/promote_homebrew_binaries.sh X.Y.Z` (or the CI workflow) to
   copy assets here and rewrite the formula.
4. End users `brew upgrade tachi` — no Rust toolchain required.
