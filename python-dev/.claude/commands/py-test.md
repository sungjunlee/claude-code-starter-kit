# /test - Run Python Tests

Comprehensive testing command for Python projects using pytest.

## Usage

```bash
/test [options]
```

## What it does

Executes the project's test suite with intelligent defaults and comprehensive reporting:

1. **Runs pytest** with optimized configuration
2. **Generates coverage reports** (terminal + HTML)
3. **Provides detailed output** for failures
4. **Supports test filtering** by markers, keywords, or paths

## Commands Executed

```bash
# Basic test run with coverage
pytest --cov=src --cov-report=term-missing --cov-report=html -v

# Fast test run (no coverage)
pytest -v --tb=short

# Parallel test execution
pytest -n auto --cov=src --cov-report=term-missing

# Specific test categories
pytest -m "not slow" --cov=src --cov-report=term-missing
```

## Configuration

The command uses configuration from `pyproject.toml`:

```toml
[tool.pytest.ini_options]
minversion = "7.0"
addopts = [
    "--strict-markers",
    "--strict-config", 
    "--cov=src",
    "--cov-report=term-missing",
    "--cov-report=html",
]
testpaths = ["tests"]
markers = [
    "slow: marks tests as slow (deselect with '-m \"not slow\"')",
    "integration: marks tests as integration tests",
    "unit: marks tests as unit tests",
]
```

## Examples

```bash
# Run all tests with coverage
/test

# Run tests quickly without coverage
/test --no-cov

# Run only unit tests
/test -m unit

# Run tests in parallel
/test -n auto

# Run tests with verbose output
/test -v -s

# Run specific test file
/test tests/test_api.py

# Run tests matching pattern
/test -k "test_user"
```

## Output

The command provides:
- **Test results** with pass/fail status
- **Coverage percentage** for each module
- **Missing lines** that need test coverage
- **HTML coverage report** in `htmlcov/` directory
- **Performance timing** for slow tests

## Integration

- **Hooks**: Automatically triggered by file changes via Claude Code hooks
- **CI/CD**: Configuration compatible with GitHub Actions, GitLab CI
- **IDE**: Results displayed in VS Code test explorer
- **Coverage**: Integrates with codecov.io and other coverage services

This command ensures comprehensive test coverage and maintains high code quality standards.