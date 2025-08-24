# /release - Semantic Release Management

Automates version bumping, changelog generation, and release creation based on commit messages.

## Usage

```bash
/release [options]
```

## What it does

Manages releases using semantic versioning:

1. **Analyzes commits** since last release
2. **Determines version bump** (major/minor/patch)
3. **Updates version** in pyproject.toml
4. **Generates changelog** from commit messages
5. **Creates git tag** and GitHub release
6. **Publishes package** (optional)

## Commit Message Convention

Follow Conventional Commits for automatic versioning:

```bash
# Patch Release (1.0.0 → 1.0.1)
fix: correct validation error in user input
fix(auth): resolve login timeout issue

# Minor Release (1.0.0 → 1.1.0)  
feat: add dark mode support
feat(api): implement webhook endpoints

# Major Release (1.0.0 → 2.0.0)
feat!: redesign API authentication
BREAKING CHANGE: removed deprecated endpoints
```

## Release Process

### Automatic Version Detection
```bash
# Check what version would be released
/release --dry-run

# Output example:
# Current version: 1.2.3
# Next version: 1.3.0 (minor)
# Changes:
#   - feat: add user profile API
#   - fix: correct date formatting
```

### Create Release
```bash
# Create release locally
/release

# Create and push to GitHub
/release --push

# Create and publish to PyPI
/release --publish
```

## Configuration

Add to `pyproject.toml`:

```toml
[tool.semantic_release]
version_toml = ["pyproject.toml:project.version"]
version_pattern = ["src/__init__.py:__version__"]
branch = "main"
changelog_file = "CHANGELOG.md"
build_command = "python -m build"
dist_path = "dist/"
upload_to_release = true
upload_to_pypi = false
remove_dist = false
patch_without_tag = false

[tool.semantic_release.commit_parser_options]
allowed_types = ["build", "chore", "ci", "docs", "feat", "fix", "perf", "style", "refactor", "test"]
minor_types = ["feat"]
patch_types = ["fix", "perf"]
```

## Options

```bash
# Preview only (no changes)
/release --dry-run

# Force specific version
/release --version 2.0.0

# Skip changelog generation
/release --no-changelog

# Skip git tag
/release --no-tag

# Include pre-release
/release --prerelease alpha

# Custom commit range
/release --from v1.0.0 --to HEAD
```

## Changelog Format

Generated `CHANGELOG.md`:

```markdown
# Changelog

## v1.3.0 (2024-01-15)

### Features
- Add dark mode support ([commit](link))
- Implement webhook endpoints ([commit](link))

### Bug Fixes
- Resolve login timeout issue ([commit](link))
- Correct validation error ([commit](link))

### Breaking Changes
None

---

## v1.2.0 (2024-01-01)
...
```

## Pre-release Workflow

```bash
# Alpha release: 1.2.0-alpha.1
/release --prerelease alpha

# Beta release: 1.2.0-beta.1
/release --prerelease beta

# Release candidate: 1.2.0-rc.1
/release --prerelease rc

# Final release: 1.2.0
/release
```

## CI/CD Integration

### GitHub Actions
```yaml
name: Release
on:
  push:
    branches: [main]
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Semantic Release
        run: |
          pip install python-semantic-release
          semantic-release publish
```

### Manual Trigger
```bash
# From Claude Code
/release --push --publish

# From command line
semantic-release publish
```

## Best Practices

### Commit Messages
- Use clear, descriptive messages
- Follow conventional format consistently
- Include scope for clarity: `feat(api): ...`
- Add footers for issues: `Fixes #123`

### Release Strategy
- Release regularly (weekly/bi-weekly)
- Use pre-releases for major changes
- Keep CHANGELOG.md updated
- Tag releases in git
- Create GitHub releases

### Version Management
- Follow SemVer strictly
- Document breaking changes clearly
- Use pre-releases for testing
- Keep version in sync across files

## Troubleshooting

### No Version Bump Detected
- Check commit messages follow convention
- Verify commits since last tag
- Use `--force` to override

### Changelog Issues
- Ensure commits are well-formatted
- Check git history is clean
- Verify branch is up-to-date

### Publishing Failures
- Verify PyPI credentials
- Check package builds correctly
- Ensure version doesn't exist

This command streamlines the release process, ensuring consistent versioning and documentation.