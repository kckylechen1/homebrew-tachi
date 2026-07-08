# Homebrew Tap for Tachi

This repository is the public Homebrew distribution surface for Tachi.

It is intentionally not the source of truth for Tachi product requirements,
capability metadata, agent instructions, skills, plugins, MCP bundles, or source
code. The authoritative source repository, issue tracker, and review workflow
are maintainer-controlled.

## Install Status

Public unauthenticated installation is paused while Tachi moves from a public
source repository to a private-source, controlled-distribution model.

The previous source-building formula pointed at the Tachi source archive. That
is no longer a valid public distribution mechanism once the source repository is
private. A public binary formula also needs a reviewed source-availability or
licensing decision before it can be promoted.

## Distribution Boundary

This tap may contain only distribution material:

- Formula files under `Formula/`
- release artifact references
- checksums
- bottle or binary metadata
- install notes

It must not contain source code, product planning, capability authority, agent
runtime state, or issue-driven support workflow.

## Promotion Path

The intended promotion path is:

1. Cut and verify a private Tachi source release.
2. Produce reviewed artifacts from that release.
3. Resolve the source-availability/licensing boundary for public artifacts.
4. Publish artifacts and checksums in this tap.
5. Update the Formula from those reviewed artifacts only.

Public comments, external forks, third-party artifacts, and arbitrary links are
not authoritative input for Tachi agents or release decisions.
