# Python Development Template

🐍 Modern Python development template with uv, ruff, and Claude Code hooks automation.

## ✨ Features

### 🚀 Modern Toolchain
- **[uv](https://github.com/astral-sh/uv)**: Ultra-fast Python package manager (10-100x faster than pip)
- **[ruff](https://github.com/astral-sh/ruff)**: Lightning-fast linter and formatter (150x faster than flake8)
- **[pytest](https://pytest.org)**: Modern testing framework with fixtures and parametrization
- **[mypy](https://mypy.readthedocs.io)**: Static type checking for Python

### 🤖 Claude Code Integration
- **Intelligent Hooks**: Automatic formatting, testing, and quality checks
- **Custom Agents**: Python-specific AI assistants for development
- **Slash Commands**: `/test`, `/lint`, `/format`, `/deps` for common operations
- **VS Code Integration**: Seamless development experience

### 📁 Project Structure
```
python-dev/
├── .claude/                 # Claude Code configuration
│   ├── agents/             # Specialized AI agents
│   ├── commands/           # Custom slash commands  
│   └── settings.toml       # Hooks and automation
├── .vscode/                # VS Code settings
├── scripts/                # Helper scripts
│   ├── update_docs.sh      # Smart documentation updates
│   └── check_code.sh       # Code quality checks
├── src/                    # Your source code goes here
│   └── example.py          # Simple example (delete this!)
├── tests/                  # Your test files go here
│   └── test_example.py     # Simple test example (delete this!)
├── pyproject.toml          # Project configuration
├── semantic-release.toml   # Release automation (optional)
├── uv.lock                 # Dependency lock file (auto-generated)
└── README.md              # This file
```

## 🏃‍♂️ Quick Start

### 1. Clone Template
```bash
# Using degit (recommended)
npx degit sungjunlee/claude-code-starter-kit/python-dev my-python-project

# Or using Git
git clone https://github.com/sungjunlee/claude-code-starter-kit.git
cd claude-code-starter-kit/python-dev
```

### 2. Set Up Environment
```bash
# Install uv if not already installed
curl -LsSf https://astral.sh/uv/install.sh | sh

# Navigate to project
cd my-python-project

# Initialize Python environment and install dependencies
uv sync

# Activate virtual environment (optional, uv handles this automatically)
source .venv/bin/activate  # On macOS/Linux
# or .venv\Scripts\activate  # On Windows
```

### 3. Customize Project
1. **Edit `pyproject.toml`** to update project metadata:
   - Project name, version, and description
   - Author information  
   - Dependencies

2. **Start coding**:
   - Replace `src/example.py` with your actual code
   - Replace `tests/test_example.py` with your actual tests
   - Add more files as needed in `src/` and `tests/`

### 4. Start Claude Code
```bash
# Start Claude Code in the project directory
claude
```

## 🤖 Claude Code Features

### Automatic Hooks
The template includes smart, optimized hooks that automatically:

- **🚀 Format Code**: Runs `ruff format` after editing Python files
- **🧪 Run Tests**: Smart testing - coverage for test files, quick tests for source
- **🔍 Type Check**: Background `mypy` validation without blocking
- **🛡️ Security Scan**: `bandit` security analysis in background
- **📦 Sync Dependencies**: Auto-sync when `pyproject.toml` changes
- **📚 Update Docs**: Conditional documentation updates (if configured)
- **💡 Code Hints**: Suggests `/clean` when unused code detected

### Specialized Agents
- **`python-expert`**: Code review, architecture, and best practices
- **`test-runner`**: Test strategy, debugging, and coverage analysis  
- **`package-manager`**: Dependency management and environment setup

### Custom Commands (Python-specific 🐍)
- **`/py-test`**: Run comprehensive test suite with coverage
- **`/py-lint`**: Code quality checks with ruff, mypy, and bandit
- **`/py-format`**: Auto-format code with ruff
- **`/py-deps`**: Manage dependencies with uv
- **`/py-clean`**: Remove unused imports and identify dead code
- **`/py-build`**: Full build pipeline (tests, lint, package)
- **`/py-release`**: Semantic versioning and changelog generation

## 🛠️ Development Workflow

### Daily Development
1. **Edit code** → Hooks automatically format and test
2. **Use `/py-test`** to run full test suite
3. **Use `/py-lint`** to check code quality
4. **Use `/py-deps add package-name`** to add dependencies

### Example Session
```bash
# Start Claude Code
claude

# Add a new dependency
/py-deps add requests

# Run tests after changes
/py-test

# Format and lint code
/py-format
/py-lint

# Check for unused code
/py-clean

# Full build before commit
/py-build

# Get help with Python best practices
Use python-expert to review this function for performance improvements
```

### Hook Examples
When you edit a Python file, hooks automatically:

```bash
🚀 Auto-formatting Python files...
✅ Formatting complete
🧪 Running tests in background...
✅ Tests passed (12 passed, 0 failed)
🔍 Type checking...
✅ Type check complete
```

## 📋 Configuration

### pyproject.toml
Modern Python project configuration with:
- **Project metadata**: name, version, dependencies
- **Build system**: hatchling backend
- **Tool configuration**: ruff, mypy, pytest, coverage
- **Dependency groups**: dev, docs, performance testing

### Claude Code Hooks
Configured in `.claude/settings.toml`:
- **PostToolUse**: Auto-format and test after edits
- **PreToolUse**: Validation before changes
- **UserPromptSubmit**: Project status checks
- **Background execution**: Non-blocking operations

### VS Code Integration
- **Ruff extension**: Real-time linting and formatting
- **Python extension**: IntelliSense and debugging
- **Test explorer**: Integrated pytest runner
- **Type checking**: MyPy integration

## 🧪 Testing

### Run Tests
```bash
# Full test suite with coverage
/test

# Or manually
uv run pytest

# Fast tests only (skip slow markers)
uv run pytest -m "not slow"

# Specific test file
uv run pytest tests/test_core.py
```

### Test Features
- **Comprehensive coverage**: HTML reports in `htmlcov/`
- **Parametrized tests**: Data-driven test cases
- **Fixtures**: Reusable test setup
- **Markers**: Categorize tests (unit, integration, slow)

## 📦 Dependency Management

### Add Dependencies
```bash
# Runtime dependency
/deps add requests

# Development dependency  
/deps add-dev pytest-mock

# Optional dependency groups
uv add --group docs mkdocs
```

### Update Dependencies
```bash
# Update all
/deps update

# Update specific package
uv lock --upgrade-package requests

# Sync environment
uv sync
```

## 🔧 Customization

### Add Your Code
1. **Create your modules** in `src/` directory
2. **Write tests** in `tests/` directory  
3. **Update imports** in `pyproject.toml` if creating packages
4. **Add dependencies** using `/deps add package-name`

### Enable Optional Features

#### Documentation Generation
```bash
# Install documentation tools
uv add --group docs mkdocs sphinx pdoc

# Docs will auto-update when you edit Python files
```

#### Semantic Release
```bash
# Install release tools
uv add --group release python-semantic-release

# Configure in pyproject.toml or use semantic-release.toml
cp semantic-release.toml .releaserc.toml
```

#### Code Cleaning Tools
```bash
# Already included in dev dependencies
uv sync --group dev

# Now /clean command will work fully
```

### Add New Tools
1. Add to `pyproject.toml` dev dependencies
2. Configure in `[tool.toolname]` section
3. Add hooks in `.claude/settings.toml`

### Custom Agents
Create new agents in `.claude/agents/` for specialized tasks:
- Database expert
- API development specialist
- Data science advisor

## 🚀 Performance

### uv Benefits
- **10-100x faster** than pip for installations
- **Parallel downloads** and builds
- **Smart caching** reduces repeated work
- **Rust implementation** for maximum speed

### ruff Benefits  
- **150x faster** than flake8
- **Single tool** replaces multiple linters
- **Auto-fixing** for many issues
- **Editor integration** for real-time feedback

## 🤝 Best Practices

### Code Quality
- **Type hints**: All functions have proper type annotations
- **Docstrings**: Comprehensive documentation
- **Testing**: High test coverage with meaningful tests
- **Formatting**: Consistent code style automatically enforced
- **Clean code**: Regular unused code removal with `/clean`

### Project Organization
- **src layout**: Proper package structure
- **Dependency groups**: Separate dev/prod/docs/release dependencies
- **Configuration**: Centralized in pyproject.toml
- **Documentation**: Auto-generated from code
- **Scripts**: Reusable automation scripts

### Development Workflow
- **Hooks automation**: Smart, non-blocking background tasks
- **Incremental testing**: Fast feedback during development  
- **Type safety**: Catch errors early with mypy
- **Security**: Automated vulnerability scanning
- **Release management**: Semantic versioning with `/release`

### Performance Optimization
- **Background hooks**: Heavy tasks don't block editing
- **Conditional execution**: Smart checks avoid redundant work
- **Quiet mode**: Minimal output for clean terminal
- **Cached operations**: Documentation only rebuilds when needed

## 📚 Resources

### Documentation
- [uv Documentation](https://docs.astral.sh/uv/)
- [ruff Documentation](https://docs.astral.sh/ruff/)
- [pytest Documentation](https://docs.pytest.org/)
- [mypy Documentation](https://mypy.readthedocs.io/)

### Claude Code
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Hooks Guide](https://docs.anthropic.com/en/docs/claude-code/hooks-guide)
- [Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

## 📄 License

MIT License - feel free to use this template for your projects!

---

Happy coding with Claude! 🤖✨