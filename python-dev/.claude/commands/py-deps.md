# /deps - Dependency Management

Modern dependency management using uv for fast and reliable package operations.

## Usage

```bash
/deps [command] [options]
```

## What it does

Comprehensive dependency management operations using uv:

1. **Install dependencies** from pyproject.toml and uv.lock
2. **Add new packages** with automatic dependency resolution
3. **Update packages** to latest compatible versions
4. **Remove packages** and clean up unused dependencies
5. **Sync environment** to match lock file exactly
6. **Security audit** for known vulnerabilities

## Commands Available

### Sync Environment
```bash
# Sync to exact lock file state
uv sync

# Sync with dev dependencies
uv sync --group dev

# Sync all dependency groups
uv sync --all-groups
```

### Add Dependencies
```bash
# Add runtime dependency
uv add requests

# Add development dependency
uv add --dev pytest ruff mypy

# Add with version constraint
uv add "fastapi>=0.100.0,<1.0.0"

# Add from git repository
uv add git+https://github.com/user/repo.git
```

### Remove Dependencies
```bash
# Remove package
uv remove requests

# Remove dev dependency
uv remove --dev pytest

# Remove multiple packages
uv remove requests click typer
```

### Update Dependencies
```bash
# Update all dependencies
uv lock --upgrade

# Update specific package
uv lock --upgrade-package requests

# Update to latest versions
uv sync --upgrade
```

## Examples

```bash
# Install all project dependencies
/deps sync

# Add a new web framework
/deps add fastapi uvicorn

# Add development tools
/deps add-dev pytest-cov black ruff

# Remove unused package
/deps remove old-package

# Update all dependencies
/deps update

# Security audit
/deps audit

# Show dependency tree
/deps tree

# Clean up environment
/deps clean
```

## Project Configuration

Dependencies are managed through `pyproject.toml`:

```toml
[project]
dependencies = [
    "requests>=2.31.0",
    "click>=8.0.0",
]

[project.optional-dependencies]
dev = [
    "ruff>=0.11.0",
    "mypy>=1.7.0", 
    "pytest>=7.4.0",
    "pytest-cov>=4.1.0",
]

docs = [
    "mkdocs>=1.5.0",
    "mkdocs-material>=9.4.0",
]
```

## Lock File Management

uv maintains `uv.lock` for reproducible builds:
- **Exact versions** for all dependencies and sub-dependencies
- **Platform-specific** builds when needed
- **Hash verification** for security
- **Fast resolution** using Rust-based resolver

## Integration Features

### Virtual Environment
- **Automatic creation** in `.venv/`
- **Isolated dependencies** from system Python
- **Cross-platform** compatibility
- **Python version management** with `uv python`

### CI/CD Integration
```bash
# Install exact versions from lock
uv sync --frozen

# Install without optional dependencies
uv sync --no-group dev

# Install for production
uv sync --only-group main
```

### Security & Auditing
```bash
# Check for known vulnerabilities
uv audit

# Update security advisories
uv audit --update

# Generate requirements.txt for compatibility
uv export --format requirements-txt > requirements.txt
```

## Performance Benefits

- **10-100x faster** than pip for most operations
- **Parallel downloads** for multiple packages
- **Cached builds** for faster subsequent installs
- **Minimal network usage** with smart caching

## Troubleshooting

Common operations for dependency issues:
```bash
# Clear cache and reinstall
uv cache clean && uv sync

# Force refresh of lock file
uv lock --refresh

# Verbose output for debugging
uv sync -v

# Check environment status
uv pip list
```

This command provides modern, fast, and reliable dependency management for Python projects.