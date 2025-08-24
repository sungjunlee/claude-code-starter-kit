#!/bin/bash
# Convert markdown research document to PDF format via HTML preview

if [ "$#" -eq 0 ]; then
    echo "Usage: /export-pdf <markdown_file> [--template <template_name>]"
    echo "Templates: report (default), legal, presentation"
    echo ""
    echo "This command opens HTML preview in browser."
    echo "Use Ctrl+P (Cmd+P on Mac) to print/save as PDF."
    echo ""
    echo "Example:"
    echo "  /export-pdf report.md"
    echo "  /export-pdf legal-analysis.md --template legal"
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
echo "Opening $1 for PDF export..."
echo "💡 After browser opens, use Ctrl+P (Cmd+P on Mac) to save as PDF"
cd "$RESEARCH_DIR" && uv run scripts/convert.py "$@" --preview

if [ $? -eq 0 ]; then
    echo "✅ Browser opened for PDF export"
else
    echo "❌ Failed to open preview"
    exit 1
fi