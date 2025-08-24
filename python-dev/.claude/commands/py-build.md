# /build - Full Project Build

Runs the complete build pipeline including tests, linting, type checking, and packaging.

## Usage

```bash
/build [options]
```

## What it does

Executes a comprehensive build process:

1. **Dependencies** - Syncs and validates all dependencies
2. **Formatting** - Applies code formatting with ruff
3. **Linting** - Runs all code quality checks
4. **Type Checking** - Validates type hints with mypy
5. **Testing** - Runs full test suite with coverage
6. **Security** - Scans for vulnerabilities
7. **Documentation** - Builds documentation (if configured)
8. **Package** - Creates distribution packages

## Build Pipeline

```bash
# 1. Environment Setup
uv sync
uv pip list

# 2. Code Quality
ruff check src/ tests/
ruff format src/ tests/
mypy src/

# 3. Testing
pytest --cov=src --cov-report=html --cov-report=term

# 4. Security
bandit -r src/
pip-audit

# 5. Documentation (if available)
bash scripts/update_docs.sh

# 6. Build Package
python -m build
```

## Options

```bash
# Quick build (skip slow steps)
/build --quick

# Only run tests
/build --test-only

# Skip tests
/build --skip-tests  

# Verbose output
/build --verbose

# Clean build (remove caches first)
/build --clean
```

## Build Stages

### Stage 1: Preparation
- Clean previous build artifacts
- Sync dependencies
- Verify environment

### Stage 2: Quality Assurance
- Format code
- Run linters
- Type checking
- Code complexity analysis

### Stage 3: Testing
- Unit tests
- Integration tests
- Coverage reporting
- Performance tests (if configured)

### Stage 4: Security
- Dependency vulnerability scan
- Code security analysis
- License compliance check

### Stage 5: Packaging
- Build wheel and sdist
- Generate documentation
- Create release notes

## Output

Build artifacts are placed in:
- `dist/` - Package files (.whl, .tar.gz)
- `htmlcov/` - Test coverage reports
- `docs/_build/` - Documentation
- `.coverage` - Coverage data
- `build/` - Build intermediates

## Exit Codes

- `0` - Build successful
- `1` - Linting/formatting issues
- `2` - Test failures
- `3` - Type checking errors
- `4` - Security vulnerabilities
- `5` - Build/packaging errors

## CI/CD Integration

This command can be used in CI/CD pipelines:

```yaml
# GitHub Actions example
- name: Build Project
  run: |
    claude --dangerously-skip-permissions /build --verbose
```

## Performance

Typical build times:
- Quick build: ~30 seconds
- Full build: 2-5 minutes
- Clean build: 3-7 minutes

Speed optimizations:
- Parallel test execution
- Incremental type checking
- Cached dependencies
- Smart documentation updates

## Troubleshooting

### Build Failures
1. Check error messages for specific failures
2. Run individual stages to isolate issues
3. Clear caches with `--clean` option
4. Verify dependencies with `uv sync`

### Slow Builds
1. Use `--quick` for development builds
2. Enable test parallelization
3. Skip documentation with `--skip-docs`
4. Use incremental builds when possible

This command ensures your project is production-ready before deployment or release.