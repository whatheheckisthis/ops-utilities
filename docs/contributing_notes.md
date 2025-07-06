
Contributing Notes

This repository supports secure Bash utilities and Conda-based validation tooling. Whether you're fixing a bug, hardening a script, or restructuring folders, this guide outlines expected standards.

---

### Scope

- Tools for daily ops, CI verification, changelog support, and bash-based automation.
- Primary use cases: environment readiness, secure file handling, lint/test automation, and changelog scripting.

---

### Directory Overview

| Folder | Purpose |
|--------|---------|
| `ci/` | CI-specific scripts (lint, imports, env verification) |
| `scripts/` | Standalone Bash utilities for secure ops |
| `config/` | Config files like `.flake8`, `environment.yml` |
| `docs/` | Overview files, CI guidance, usage notes |
| `tests/` | Unit and integration test scaffolds |
| `bin/` | Legacy, redundant, or archived scripts |

---

### Checklist: Adding a New Script

- [ ] Placed in correct subdirectory (`ci/`, `scripts/`, `bin/`, etc.)
- [ ] Does not hardcode absolute paths
- [ ] Runs cleanly without error
- [ ] Includes inline comments where necessary
- [ ] Output is user-readable and fails gracefully
- [ ] Is covered in the `README.md` or linked documentation
- [ ] Has file permissions set: `chmod +x script.sh`

---

### GitHub Actions Integration

- Use `bash -l {0}` shell for proper environment activation
- Use `environment.yml` for dependency installation
- Pin `miniforge-version` to prevent CI breakage
- Use `run_all_checks.sh` to aggregate and verify all scripts

```yaml
name: CI environment check
shell: bash -l {0}
run: |
'bash ci/run_all_checks.sh'
