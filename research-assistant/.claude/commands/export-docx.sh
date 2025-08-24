#!/bin/bash
# Convert markdown research document to DOCX format

if [ "$#" -eq 0 ]; then
    echo "Usage: /export-docx <markdown_file> [--template <template_name>]"
    echo "Templates: report (default), legal, presentation"
    echo ""
    echo "Example:"
    echo "  /export-docx report.md"
    echo "  /export-docx legal-analysis.md --template legal"
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
echo "Converting $1 to DOCX format..."
cd "$RESEARCH_DIR" && uv run scripts/convert.py "$@" --docx

if [ $? -eq 0 ]; then
    echo "✅ Successfully converted to DOCX"
else
    echo "❌ Conversion failed"
    exit 1
fi