# /lint - Code Quality Check

Comprehensive code quality analysis using ruff, mypy, and bandit.

## Usage

```bash
/lint [options]
```

## What it does

Performs comprehensive code quality checks and analysis:

1. **Ruff linting** - Fast Python linter for code style and bugs
2. **Ruff formatting** - Automatic code formatting 
3. **Type checking** - Static type analysis with mypy
4. **Security scanning** - Security vulnerability detection with bandit
5. **Import sorting** - Automatic import organization

## Commands Executed

```bash
# Full lint suite
ruff check src/ tests/
ruff format src/ tests/ --diff
mypy src/
bandit -r src/ -f txt

# Auto-fix mode
ruff check --fix src/ tests/
ruff format src/ tests/

# Check only (no fixes)
ruff check src/ tests/ --no-fix
```

## Configuration

Uses configuration from `pyproject.toml`:

```toml
[tool.ruff]
target-version = "py310"
line-length = 88
src = ["src", "tests"]

[tool.ruff.lint]
select = [
    "E",   # pycodestyle errors
    "W",   # pycodestyle warnings  
    "F",   # pyflakes
    "I",   # isort
    "B",   # flake8-bugbear
    "C4",  # flake8-comprehensions
    "UP",  # pyupgrade
    "ARG", # flake8-unused-arguments
    "SIM", # flake8-simplify
    "TCH", # flake8-type-checking
]

[tool.mypy]
python_version = "3.10"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
check_untyped_defs = true
```

## Examples

```bash
# Full quality check
/lint

# Auto-fix issues
/lint --fix

# Check specific directory
/lint src/

# Only type checking
/lint --mypy-only

# Only security scan
/lint --security-only

# Skip slow checks
/lint --fast
```

## Output

The command reports:
- **Code style violations** with file locations and suggestions
- **Type errors** with detailed explanations
- **Security vulnerabilities** with severity ratings
- **Import organization** issues
- **Performance suggestions** for better code

## Integration

- **Pre-commit**: Automatically runs before commits
- **IDE**: Real-time linting in VS Code
- **CI/CD**: Quality gates in automation pipelines
- **Hooks**: Triggered automatically by Claude Code hooks after file edits

## Rules Enforced

### Code Style (Ruff)
- PEP 8 compliance
- Import sorting and organization
- Unused variable detection
- Code complexity analysis
- Modern Python feature suggestions

### Type Safety (MyPy)
- Function signature validation
- Return type checking
- Variable type consistency
- Generic type usage
- Protocol compliance

### Security (Bandit)
- SQL injection vulnerabilities
- Shell injection risks
- Cryptography issues
- File handling security
- Network security concerns

This command maintains high code quality standards and catches issues early in the development process.