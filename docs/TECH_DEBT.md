# Technical Debt

Tracks known technical work that is intentionally postponed.

Technical debt is not failure.

Technical debt is a conscious decision to preserve architectural stability.

---

## TD-001

Title:
Octagon visual refinement

Status:
Observed

Priority:
Low

Reason:

The octagon communicates the intended geometric presence, but its diagonal edges lose contrast at normal viewing distances.

It is functional.

It is not yet visually optimal.

---

## TD-002

Title:
Asset optimization pipeline

Status:
Deferred

Priority:
Medium

Reason:

HTML/CSS minification, SVG optimization and asset compression will be introduced only when a justified build or optimization pipeline exists.

Current development prioritizes architectural stability over premature optimization.

---

## TD-003

Title:
CI-based validation

Status:
Deferred

Priority:
Medium

Reason:

Local automated validation is now implemented through `scripts/validate.ps1` and its individual checks.

CI-based execution remains intentionally deferred because the project currently has no build or deployment pipeline requiring GitHub Actions.

---

## TD-004

Title:
Hero CTA hierarchy

Status:
Deferred

Priority:
Low

Reason:

Current Hero satisfies structural goals.

Primary and secondary action hierarchy can be refined after content exists.

---

## Principles

Technical debt must be:

- Explicit.
- Documented.
- Intentional.
- Reviewable.

Undocumented debt does not exist.

---

## TD-005

Title:
Standardize Exhibit Directory

Status:
Completed

Reason:

Published exhibits now follow the numbered directory convention:

exhibits/
    001-...
    002-...
    003-...
    004-...
    005-...

---

## TD-006

Title:
Repository naming consistency

Status:
Completed

Priority:
Low

Reason:

The component directory convention was standardized to `components/`.

The current repository contains the canonical `components/` directory.
