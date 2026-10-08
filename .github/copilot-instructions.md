# Copilot instructions

## Project shape

- The repository root is a static GitHub Pages site. `index.html` is the public portfolio; pages link directly to files and assets, with no framework, package manager, or application build step.
- `assets/css/index.css` is the stylesheet entry point. It imports the design tokens and focused stylesheets for layout, components, sections, and page elements. `assets/js/` contains only auxiliary site behavior; core exhibit content must remain understandable without client-side execution.
- `exhibits/` contains standalone, numbered demonstrations. Each exhibit has an `index.html` for the public presentation and a `README.md` for its full documentation. Keep the evidence and implementation aligned.
- `toroide/` is internal architecture and project documentation, not website runtime content. `docs/` contains public-facing supporting material. Check these before changing structure or project intent; important decisions and principles are documented there.
- `tools/` contains Python text-processing helpers. These tools are separate from the static site.

## Project conventions

- Follow the documentation-first project loop: observation, research, audit, decision, implementation, documentation. Base claims on observable evidence; do not introduce unsupported content or complexity for its own sake.
- Keep each CSS file focused on one responsibility. Put shared visual values in `assets/css/tokens.css` instead of introducing unrelated hard-coded colors.
- Preserve semantic HTML and the separation of responsibilities: HTML for meaning, CSS for presentation, JavaScript for behavior. Exhibits should remain understandable as static pages; do not make their core content depend on JavaScript.
- An exhibit should present its title and status, question, observation, evidence, current status, and a link to its full documentation. Keep the README as the detailed source and HTML as the concise public presentation.
- The project's `toroide/AI_TEAM.md` assigns Copilot micro-refactors and minor changes. For broader architectural changes, follow documented decisions and principles rather than redesigning the system unilaterally.

## Validation and release

- There is no application build step, package manager, framework, or required browser-test command.
- The repository has a local PowerShell validation suite under `scripts/`.
- Run the complete validation suite from the repository root with:
  `powershell -ExecutionPolicy Bypass -File .\scripts\validate.ps1`
- Individual checks are available as `check-links.ps1`, `check-assets.ps1`, `check-html.ps1`, `check-css.ps1`, `check-encoding.ps1`, and `check-duplicates.ps1`.
- The canonical release flow is: edit → validate → commit → push → GitHub Pages deployment → production verification.
- Do not introduce Node.js, npm, bundlers, frameworks, or CI infrastructure unless a documented architectural decision requires them.

## Auxiliary Python tooling

- The repository also contains Python tooling and MCP-related tests under the repository root and `tools/`.
- These tools are separate from the static GitHub Pages runtime.
- Do not treat the `/mcp` service checks as part of the static-site validation suite.
