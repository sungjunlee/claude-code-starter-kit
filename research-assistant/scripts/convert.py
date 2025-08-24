#!/usr/bin/env -S uv run
# /// script
# dependencies = [
#     "pypandoc",
#     "markdown2",
#     "jinja2",
#     "openpyxl",
#     "beautifulsoup4",
#     "click",
# ]
# requires-python = ">=3.10"
# ///

"""
Document Converter for Research Assistant
Converts markdown research reports to various formats (PDF, DOCX, XLSX)
"""

import click
import os
import sys
import webbrowser
import tempfile
import re
from pathlib import Path
from datetime import datetime
from typing import Optional, List, Dict

import markdown2
from jinja2 import Template, FileSystemLoader, Environment
from bs4 import BeautifulSoup
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment

# Get script directory for templates and styles
SCRIPT_DIR = Path(__file__).parent.resolve()
TEMPLATE_DIR = SCRIPT_DIR.parent / "templates"
STYLE_DIR = SCRIPT_DIR.parent / "styles"

# Default HTML template if no template file exists
DEFAULT_TEMPLATE = """
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ title }}</title>
    <style>
        /* Basic styling for professional documents */
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap');
        
        body {
            font-family: 'Noto Sans KR', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        
        h1 { 
            color: #2c3e50;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }
        
        h2 {
            color: #34495e;
            margin-top: 30px;
            border-bottom: 1px solid #ecf0f1;
            padding-bottom: 5px;
        }
        
        h3 { color: #7f8c8d; }
        
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
        }
        
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        
        th {
            background-color: #3498db;
            color: white;
            font-weight: bold;
        }
        
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        blockquote {
            border-left: 4px solid #3498db;
            margin: 20px 0;
            padding-left: 20px;
            color: #555;
            font-style: italic;
        }
        
        code {
            background-color: #f4f4f4;
            padding: 2px 6px;
            border-radius: 3px;
            font-family: 'Courier New', monospace;
        }
        
        pre {
            background-color: #f4f4f4;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
        }
        
        a {
            color: #3498db;
            text-decoration: none;
        }
        
        a:hover {
            text-decoration: underline;
        }
        
        .metadata {
            background-color: #ecf0f1;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        
        .metadata p {
            margin: 5px 0;
        }
        
        @media print {
            body {
                font-size: 11pt;
                line-height: 1.5;
            }
            
            h1 { page-break-after: avoid; }
            h2, h3 { page-break-after: avoid; }
            
            table { page-break-inside: avoid; }
            
            .metadata {
                background-color: #f5f5f5 !important;
                -webkit-print-color-adjust: exact;
                color-adjust: exact;
            }
        }
    </style>
    {% if custom_css %}
    <style>{{ custom_css }}</style>
    {% endif %}
</head>
<body>
    {% if metadata %}
    <div class="metadata">
        {% if metadata.title %}<p><strong>제목:</strong> {{ metadata.title }}</p>{% endif %}
        {% if metadata.date %}<p><strong>작성일:</strong> {{ metadata.date }}</p>{% endif %}
        {% if metadata.author %}<p><strong>작성자:</strong> {{ metadata.author }}</p>{% endif %}
        {% if metadata.agents %}<p><strong>사용 에이전트:</strong> {{ metadata.agents }}</p>{% endif %}
        {% if metadata.sources_count %}<p><strong>참조 출처:</strong> {{ metadata.sources_count }}개</p>{% endif %}
    </div>
    {% endif %}
    
    {{ content }}
    
    <footer style="margin-top: 50px; padding-top: 20px; border-top: 1px solid #ddd; color: #666; font-size: 0.9em;">
        <p>생성일: {{ generated_date }}</p>
    </footer>
</body>
</html>
"""


def extract_metadata(markdown_text: str) -> tuple[dict, str]:
    """Extract YAML frontmatter from markdown"""
    metadata = {}
    content = markdown_text
    
    # Check for YAML frontmatter
    if markdown_text.startswith('---'):
        try:
            end_index = markdown_text.index('---', 3)
            yaml_text = markdown_text[3:end_index].strip()
            content = markdown_text[end_index + 3:].strip()
            
            # Simple YAML parsing (for basic key-value pairs)
            for line in yaml_text.split('\n'):
                if ':' in line:
                    key, value = line.split(':', 1)
                    metadata[key.strip()] = value.strip()
        except ValueError:
            pass
    
    return metadata, content


def markdown_to_html(markdown_file: Path, template_name: Optional[str] = None) -> str:
    """Convert markdown to HTML with template"""
    
    # Read markdown file
    with open(markdown_file, 'r', encoding='utf-8') as f:
        markdown_text = f.read()
    
    # Extract metadata and content
    metadata, content = extract_metadata(markdown_text)
    
    # Convert markdown to HTML
    html_content = markdown2.markdown(
        content,
        extras=['tables', 'fenced-code-blocks', 'footnotes', 'strike', 'task_list']
    )
    
    # Load template
    if template_name and TEMPLATE_DIR.exists():
        env = Environment(loader=FileSystemLoader(TEMPLATE_DIR))
        try:
            template = env.get_template(f"{template_name}.html")
        except:
            template = Template(DEFAULT_TEMPLATE)
    else:
        template = Template(DEFAULT_TEMPLATE)
    
    # Load custom CSS if available
    custom_css = ""
    css_file = STYLE_DIR / "professional.css"
    if css_file.exists():
        with open(css_file, 'r', encoding='utf-8') as f:
            custom_css = f.read()
    
    # Render HTML
    html = template.render(
        title=metadata.get('title', markdown_file.stem),
        metadata=metadata if metadata else None,
        content=html_content,
        custom_css=custom_css,
        generated_date=datetime.now().strftime('%Y-%m-%d %H:%M')
    )
    
    return html


def html_to_docx(markdown_file: Path, output_file: Optional[Path] = None) -> Path:
    """Convert markdown to DOCX using pypandoc"""
    try:
        import pypandoc
    except ImportError:
        click.echo("⚠️  pypandoc를 설치하는 중입니다. 잠시만 기다려주세요...")
        import subprocess
        subprocess.run([sys.executable, "-m", "pip", "install", "pypandoc"], check=True)
        import pypandoc
    
    if output_file is None:
        output_file = markdown_file.with_suffix('.docx')
    
    # Convert directly using pypandoc
    pypandoc.convert_file(
        str(markdown_file),
        'docx',
        outputfile=str(output_file),
        extra_args=['--standalone', '--toc']
    )
    
    return output_file


def extract_tables_to_excel(markdown_file: Path, output_file: Optional[Path] = None) -> Path:
    """Extract tables from markdown and save to Excel"""
    if output_file is None:
        output_file = markdown_file.with_suffix('.xlsx')
    
    # Read and convert markdown
    with open(markdown_file, 'r', encoding='utf-8') as f:
        markdown_text = f.read()
    
    _, content = extract_metadata(markdown_text)
    html_content = markdown2.markdown(content, extras=['tables'])
    
    # Parse HTML to find tables
    soup = BeautifulSoup(html_content, 'html.parser')
    tables = soup.find_all('table')
    
    if not tables:
        click.echo("⚠️  문서에서 표를 찾을 수 없습니다.")
        return None
    
    # Create Excel workbook
    wb = openpyxl.Workbook()
    wb.remove(wb.active)  # Remove default sheet
    
    # Header style
    header_font = Font(bold=True, color="FFFFFF")
    header_fill = PatternFill(start_color="366092", end_color="366092", fill_type="solid")
    header_align = Alignment(horizontal="center", vertical="center")
    
    for idx, table in enumerate(tables, 1):
        # Create sheet for each table
        sheet_name = f"Table_{idx}"
        ws = wb.create_sheet(title=sheet_name)
        
        # Extract rows
        rows = table.find_all('tr')
        for row_idx, row in enumerate(rows, 1):
            cells = row.find_all(['th', 'td'])
            for col_idx, cell in enumerate(cells, 1):
                cell_value = cell.get_text(strip=True)
                ws.cell(row=row_idx, column=col_idx, value=cell_value)
                
                # Style header row
                if row.find('th'):
                    ws.cell(row=row_idx, column=col_idx).font = header_font
                    ws.cell(row=row_idx, column=col_idx).fill = header_fill
                    ws.cell(row=row_idx, column=col_idx).alignment = header_align
        
        # Adjust column widths
        for column in ws.columns:
            max_length = 0
            column_letter = column[0].column_letter
            for cell in column:
                if cell.value:
                    max_length = max(max_length, len(str(cell.value)))
            adjusted_width = min(max_length + 2, 50)
            ws.column_dimensions[column_letter].width = adjusted_width
    
    # Save workbook
    wb.save(output_file)
    return output_file


@click.command()
@click.argument('markdown_file', type=click.Path(exists=True, path_type=Path))
@click.option('--preview', is_flag=True, help='브라우저에서 미리보기')
@click.option('--docx', is_flag=True, help='DOCX (Word) 파일로 변환')
@click.option('--excel', is_flag=True, help='표를 Excel 파일로 추출')
@click.option('--template', default=None, help='사용할 HTML 템플릿 (report, legal, presentation)')
@click.option('--output', '-o', type=click.Path(), help='출력 파일 경로')
def convert(markdown_file: Path, preview: bool, docx: bool, excel: bool, 
            template: Optional[str], output: Optional[str]):
    """
    연구 문서를 다양한 형식으로 변환합니다.
    
    \b
    사용 예시:
        convert.py report.md --preview     # 브라우저에서 미리보기
        convert.py report.md --docx        # Word 문서로 변환
        convert.py report.md --excel       # 표를 Excel로 추출
    """
    
    # Default to preview if no option specified
    if not any([preview, docx, excel]):
        preview = True
    
    output_path = Path(output) if output else None
    
    try:
        if preview:
            # Generate HTML and open in browser
            html = markdown_to_html(markdown_file, template)
            
            # Save to temporary file
            with tempfile.NamedTemporaryFile(mode='w', suffix='.html', delete=False, encoding='utf-8') as f:
                f.write(html)
                temp_path = f.name
            
            # Open in browser
            webbrowser.open(f'file://{temp_path}')
            click.echo(f"✅ 브라우저에서 미리보기를 열었습니다: {temp_path}")
            click.echo("💡 PDF로 저장하려면 브라우저에서 Ctrl+P (또는 Cmd+P)를 누르세요")
            
        if docx:
            output_file = html_to_docx(markdown_file, output_path)
            click.echo(f"✅ Word 문서로 변환되었습니다: {output_file}")
            
        if excel:
            output_file = extract_tables_to_excel(markdown_file, output_path)
            if output_file:
                click.echo(f"✅ Excel 파일로 표가 추출되었습니다: {output_file}")
    
    except Exception as e:
        click.echo(f"❌ 오류가 발생했습니다: {str(e)}", err=True)
        sys.exit(1)


if __name__ == '__main__':
    convert()