# Python Project Development Guide

## Project Context
<!-- TODO: Replace with your project description -->
This is a modern Python project using uv for package management and automated quality checks.

## Development Setup

**Python Version**: 3.10+  
**Virtual Environment**: `.venv/` (managed by uv)  
**Package Manager**: `uv` (NOT pip - this is critical)

## Core Commands

```bash
# Environment & Dependencies
uv sync                      # Install all dependencies
uv add <package>            # Add new dependency
uv add --dev <package>      # Add dev dependency

# Development Workflow
/py-test                    # Run tests with coverage
/py-lint                    # Run all quality checks
/py-format                  # Format code
/py-clean                   # Remove unused code
/py-build                   # Full build pipeline

# Quick Commands (most common)
uv run python src/example.py    # Run Python files
uv run pytest -xvs              # Quick test run
```

## Code Standards

- **Type Hints**: Required for all functions
- **Docstrings**: Required for public APIs
- **Line Length**: 88 characters (ruff enforced)
- **Import Order**: Automatic via ruff
- **Test Files**: `test_*.py` in `tests/` directory

## Project Structure

```
src/        # Source code (your modules here)
tests/      # Test files
scripts/    # Helper scripts (update_docs.sh, check_code.sh)
.claude/    # Claude Code configuration and commands
```

## Important Notes

### ⚠️ Package Management
**ALWAYS use `uv`, NEVER use `pip`**. Common mistakes to avoid:
- ❌ `pip install package`
- ✅ `uv add package`
- ❌ `python -m venv`
- ✅ `uv sync` (handles venv automatically)

### 🤖 Automation
This project has hooks that automatically:
- Format code on edit
- Run tests in background
- Check types and security
- Suggest `/py-clean` when needed

No need to manually run formatters or linters after edits.

### 📦 Configuration
All tool settings are in `pyproject.toml`. Don't create separate config files for:
- ruff (`.ruff.toml`)
- mypy (`mypy.ini`)
- pytest (`pytest.ini`)

## Customization Guide
<!-- Template users: Update sections above with your specifics -->
1. Replace project description
2. Add project-specific commands
3. Update code standards if needed
4. Document any special requirements