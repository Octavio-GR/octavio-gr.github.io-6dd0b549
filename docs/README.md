# Proyecto Toroide — Documentation System

## Purpose

This directory contains documentation and evidence intended to explain,
support, and expose the Toroide project.

## Documentation boundaries

### `docs/`

Published or documentation-facing material.

This includes:

- Core project documentation
- Evidence and exhibit registries
- Audits
- Milestones
- Public technical documentation
- Release-facing documentation when justified

The document index is maintained in `docs/INDEX.md`.

### `exhibits/`

Concrete evidence units.

Each exhibit contains its own implementation and local documentation.

### `toroide/`

Internal engineering knowledge.

This includes:

- architecture
- decisions
- roadmap
- structure
- engineering principles
- audit records
- project governance

### `scripts/`

Operational validation tooling.

The validation suite is intentionally lightweight and dependency-free.

## Release flow

Toroide is a static HTML/CSS site. There is no application build step.

The canonical operational flow is:

    edit
      ↓
    validate
      ↓
    commit
      ↓
    push
      ↓
    GitHub Pages deployment
      ↓
    production verification

Validation is performed locally through:

    powershell -ExecutionPolicy Bypass -File scripts/validate.ps1

## Change history

Git history is the authoritative record of implementation changes,
including the progression of exhibits, documentation, fixes, and
production hardening.

## Scope rule

Do not create empty documentation categories merely to satisfy a proposed
directory structure. A new directory should appear when real content
requires it.
