#!/bin/bash
# Conditional documentation update script
# Only runs if documentation tools are installed and configured

set -e

# Color output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check if we have any documentation setup
has_docs=false

# Check for Sphinx
if [ -f "docs/conf.py" ] && uv run python -c "import sphinx" 2>/dev/null; then
    echo -e "${GREEN}📚 Updating Sphinx documentation...${NC}"
    
    # Check if source files changed since last build
    if [ -d "docs/_build" ]; then
        if find src -name "*.py" -newer docs/_build/html/index.html 2>/dev/null | grep -q .; then
            uv run sphinx-apidoc -o docs/api src/ -f -q
            uv run sphinx-build -b html docs docs/_build/html -q
            echo -e "${GREEN}✅ Sphinx docs updated${NC}"
        else
            echo -e "${YELLOW}⏭️  No changes, skipping Sphinx docs${NC}"
        fi
    else
        # First build
        uv run sphinx-apidoc -o docs/api src/ -f -q
        uv run sphinx-build -b html docs docs/_build/html -q
        echo -e "${GREEN}✅ Sphinx docs created${NC}"
    fi
    has_docs=true
fi

# Check for MkDocs
if [ -f "mkdocs.yml" ] && uv run python -c "import mkdocs" 2>/dev/null; then
    echo -e "${GREEN}📚 Updating MkDocs documentation...${NC}"
    
    # Check if source files changed since last build
    if [ -d "site" ]; then
        if find src -name "*.py" -newer site/index.html 2>/dev/null | grep -q .; then
            uv run mkdocs build --quiet
            echo -e "${GREEN}✅ MkDocs updated${NC}"
        else
            echo -e "${YELLOW}⏭️  No changes, skipping MkDocs${NC}"
        fi
    else
        # First build
        uv run mkdocs build --quiet
        echo -e "${GREEN}✅ MkDocs created${NC}"
    fi
    has_docs=true
fi

# Check for pdoc
if uv run python -c "import pdoc" 2>/dev/null; then
    if [ ! "$has_docs" = true ]; then
        echo -e "${GREEN}📚 Generating pdoc documentation...${NC}"
        uv run pdoc --html --output-dir docs src --force
        echo -e "${GREEN}✅ pdoc documentation generated${NC}"
        has_docs=true
    fi
fi

if [ ! "$has_docs" = true ]; then
    echo -e "${YELLOW}📚 No documentation tools found. Skipping...${NC}"
    echo "   Install with: uv add --dev sphinx mkdocs pdoc"
fi