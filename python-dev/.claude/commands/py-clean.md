# /clean - Clean Code Automatically

Removes unused imports, variables, and identifies dead code in your Python project.

## Usage

```bash
/clean [options]
```

## What it does

Performs automated code cleanup operations:

1. **Removes unused imports** - Cleans up import statements not being used
2. **Removes unused variables** - Deletes variables that are defined but never used
3. **Identifies dead code** - Finds functions and classes that are never called
4. **Organizes imports** - Sorts and groups imports properly

## Process

The command follows a safe two-step process:

### Step 1: Check Mode
First runs all checks to show what would be changed:
```bash
# Check for issues without modifying files
bash scripts/check_code.sh
```

### Step 2: Interactive Confirmation
If issues are found, asks for confirmation before applying fixes:
```bash
# Apply autoflake fixes
autoflake --in-place --remove-all-unused-imports --remove-unused-variables src/

# Fix import organization
ruff check --fix --select I src/
```

## Safety Features

- **Preview changes** before applying them
- **Preserves dynamic imports** that might be used via `importlib`
- **Respects TYPE_CHECKING** imports for type hints
- **Creates backup** before major changes (optional)
- **Whitelist support** for false positives

## Examples

```bash
# Basic cleanup
/clean

# Check only, don't fix
/clean --check

# Clean specific directory
/clean src/modules/

# Aggressive mode (lower confidence threshold)
/clean --aggressive

# With backup
/clean --backup
```

## Configuration

The command respects configuration in `pyproject.toml`:

```toml
[tool.autoflake]
remove-all-unused-imports = true
remove-unused-variables = true
expand-star-imports = true
ignore-init-module-imports = true

[tool.vulture]
min_confidence = 90
paths = ["src"]
ignore_names = ["test_*", "*_fixture"]
```

## Common Patterns Preserved

The tool is smart about common Python patterns:

- **Test functions**: `test_*` methods are preserved
- **Fixtures**: `*_fixture` functions for pytest
- **Django/Flask handlers**: View functions and route handlers
- **Class methods**: `setUp`, `tearDown`, `__init__`, etc.
- **Dunder methods**: `__all__`, `__version__`, etc.

## Manual Override

If the tool incorrectly flags something as unused:

```python
# Add a comment to preserve
import important_module  # noqa: F401

# Or add to __all__
__all__ = ["important_function"]

# Or create a whitelist file
# .vulture_whitelist.txt
```

## Integration

Works seamlessly with:
- **ruff**: For import organization
- **black**: For code formatting
- **mypy**: Type checking isn't affected
- **pytest**: Test discovery remains intact

## Troubleshooting

### False Positives
If legitimate code is being flagged:
1. Check if it's used dynamically
2. Add to whitelist
3. Use `# noqa` comments
4. Adjust confidence threshold

### Not Finding Dead Code
If obvious dead code isn't detected:
1. Lower the confidence threshold
2. Check if code is imported elsewhere
3. Verify the search paths

This command helps maintain a clean, efficient codebase by removing unnecessary code clutter.