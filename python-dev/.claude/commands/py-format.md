# /format - Code Formatting

Automatic code formatting using ruff for consistent Python code style.

## Usage

```bash
/format [options]
```

## What it does

Applies consistent code formatting to Python files:

1. **Code formatting** using ruff format (Black-compatible)
2. **Import sorting** with intelligent grouping
3. **Line length** optimization (88 characters default)
4. **Quote normalization** to double quotes
5. **Trailing comma** management
6. **Whitespace cleanup** and optimization

## Commands Executed

```bash
# Format all Python files
ruff format src/ tests/

# Check formatting without changes
ruff format src/ tests/ --check

# Format with diff preview
ruff format src/ tests/ --diff

# Format specific file
ruff format path/to/file.py
```

## Configuration

Uses settings from `pyproject.toml`:

```toml
[tool.ruff.format]
quote-style = "double"
indent-style = "space"
skip-magic-trailing-comma = false
line-ending = "auto"

[tool.ruff.lint.isort]
known-first-party = ["my_python_project"]
```

## Examples

```bash
# Format entire codebase
/format

# Check if files need formatting
/format --check

# Show what would be changed
/format --diff

# Format only source code
/format src/

# Format specific file
/format src/main.py

# Format and fix imports
/format --fix-imports
```

## Formatting Rules

### Code Style
- **Line length**: 88 characters (configurable)
- **Indentation**: 4 spaces (no tabs)
- **Quotes**: Double quotes preferred
- **Trailing commas**: Added for multiline constructs
- **Parentheses**: Minimal, removed when unnecessary

### Import Organization
```python
# Standard library imports
import os
import sys
from pathlib import Path

# Third-party imports
import requests
from fastapi import FastAPI

# Local imports
from .config import settings
from .utils import helper_function
```

### Code Structure
```python
# Function definitions
def function_name(
    param_one: str,
    param_two: int = 0,
) -> str:
    """Docstring with proper formatting."""
    result = some_long_expression_that_might_need_wrapping(
        argument_one=param_one,
        argument_two=param_two,
    )
    return result

# Class definitions  
class MyClass:
    """Class docstring."""
    
    def __init__(self, value: str) -> None:
        self.value = value
    
    def method(self) -> str:
        return self.value
```

## Integration

### Editor Integration
- **VS Code**: Format on save with ruff extension
- **PyCharm**: External tool integration
- **Vim/Neovim**: Plugin integration with formatting

### Automation
- **Pre-commit hooks**: Automatic formatting before commits
- **CI/CD**: Format checking in pipelines
- **Claude Code hooks**: Auto-formatting after file edits

### Git Integration
```bash
# Format only changed files
git diff --name-only | grep "\.py$" | xargs ruff format

# Format files in current branch
git diff main --name-only | grep "\.py$" | xargs ruff format
```

## Comparison with Other Formatters

### vs Black
- **Faster**: Rust implementation vs Python
- **Compatible**: Same formatting rules by default
- **Integrated**: Combined with linting in single tool
- **Configurable**: More formatting options

### vs autopep8
- **More opinionated**: Consistent style choices
- **Better handling**: Complex expressions and imports
- **Modern**: Supports latest Python syntax
- **Comprehensive**: Handles edge cases better

## Best Practices

### Workflow Integration
1. **Format before committing** code changes
2. **Use format-on-save** in your editor
3. **Run format checks** in CI/CD pipelines
4. **Format entire codebase** periodically

### Team Collaboration
- **Consistent formatting** reduces review noise
- **Automated formatting** eliminates style debates
- **Focus on logic** rather than formatting in reviews
- **Easy onboarding** with automatic formatting

This command ensures consistent, readable Python code across your entire project.