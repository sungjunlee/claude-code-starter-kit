#!/bin/bash
# Code quality check script
# Checks for unused imports, variables, and dead code without auto-fixing

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Code Quality Check${NC}"
echo "========================"

# Track if any issues found
issues_found=false

# Check for autoflake
if command -v autoflake &> /dev/null; then
    echo -e "\n${YELLOW}Checking for unused imports and variables...${NC}"
    
    # Run autoflake in check mode
    output=$(autoflake \
        --check \
        --remove-unused-variables \
        --remove-all-unused-imports \
        --remove-duplicate-keys \
        --expand-star-imports \
        src/ 2>&1 || true)
    
    if echo "$output" | grep -q "would be reformatted"; then
        echo -e "${YELLOW}⚠️  Found unused code:${NC}"
        echo "$output" | grep -E "would be reformatted|Unused" | head -10
        echo -e "${YELLOW}   Run '/py-clean' to remove unused code${NC}"
        issues_found=true
    else
        echo -e "${GREEN}✅ No unused imports or variables${NC}"
    fi
else
    echo -e "${YELLOW}⏭️  autoflake not installed (install with: uv add --dev autoflake)${NC}"
fi

# Check for vulture (dead code detection)
if command -v vulture &> /dev/null; then
    echo -e "\n${YELLOW}Checking for dead code...${NC}"
    
    # Create temporary whitelist for common patterns
    cat > /tmp/vulture_whitelist.txt << 'EOF'
# Common patterns to ignore
_.test_*  # pytest test functions
_.*_fixture  # pytest fixtures
_.setUp  # unittest setup
_.tearDown  # unittest teardown
_.setUpClass  # unittest class setup
_.tearDownClass  # unittest class teardown
EOF
    
    # Run vulture with high confidence
    output=$(vulture src/ \
        --min-confidence 90 \
        --ignore-names "test_*,*_fixture,setUp,tearDown" \
        --whitelist /tmp/vulture_whitelist.txt \
        2>&1 || true)
    
    if [ -n "$output" ] && [ "$output" != "" ]; then
        echo -e "${YELLOW}⚠️  Possible dead code detected:${NC}"
        echo "$output" | head -15
        echo -e "${YELLOW}   Review these findings (90%+ confidence)${NC}"
        issues_found=true
    else
        echo -e "${GREEN}✅ No dead code detected${NC}"
    fi
    
    rm -f /tmp/vulture_whitelist.txt
else
    echo -e "${YELLOW}⏭️  vulture not installed (install with: uv add --dev vulture)${NC}"
fi

# Check for import sorting issues
if command -v ruff &> /dev/null; then
    echo -e "\n${YELLOW}Checking import organization...${NC}"
    
    if ruff check src/ --select I --quiet 2>/dev/null; then
        echo -e "${GREEN}✅ Imports are well organized${NC}"
    else
        echo -e "${YELLOW}⚠️  Import organization issues found${NC}"
        echo -e "${YELLOW}   Run 'ruff check --fix src/' to fix${NC}"
        issues_found=true
    fi
fi

# Summary
echo -e "\n========================"
if [ "$issues_found" = true ]; then
    echo -e "${YELLOW}💡 Code quality issues found. Run '/py-clean' to fix automatically.${NC}"
    exit 1
else
    echo -e "${GREEN}✅ All code quality checks passed!${NC}"
    exit 0
fi