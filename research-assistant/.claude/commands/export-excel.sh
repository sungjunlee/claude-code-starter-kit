#!/bin/bash
# Extract tables from markdown research document to Excel format

if [ "$#" -eq 0 ]; then
    echo "Usage: /export-excel <markdown_file>"
    echo ""
    echo "Extracts all tables from the markdown document and saves to Excel."
    echo "Each table becomes a separate worksheet."
    echo ""
    echo "Example:"
    echo "  /export-excel market-analysis.md"
    echo "  /export-excel competitive-research.md"
    exit 1
fi

# Find the research assistant directory
RESEARCH_DIR="$(pwd)"
while [[ ! -f "$RESEARCH_DIR/scripts/convert.py" && "$RESEARCH_DIR" != "/" ]]; do
    RESEARCH_DIR="$(dirname "$RESEARCH_DIR")"
done

if [[ ! -f "$RESEARCH_DIR/scripts/convert.py" ]]; then
    echo "Error: Could not find research assistant convert script"
    exit 1
fi

# Run conversion
echo "Extracting tables from $1 to Excel format..."
cd "$RESEARCH_DIR" && uv run scripts/convert.py "$1" --excel

if [ $? -eq 0 ]; then
    echo "✅ Successfully extracted tables to Excel"
else
    echo "❌ Table extraction failed"
    exit 1
fi