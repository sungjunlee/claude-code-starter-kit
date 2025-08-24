#!/bin/bash
# Quick document conversion script for research assistant
# Uses uv to run the conversion script with automatic dependency installation

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONVERT_SCRIPT="$SCRIPT_DIR/scripts/convert.py"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    print_error "uv is not installed. Please install it first:"
    echo "  curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

# Check if convert script exists
if [[ ! -f "$CONVERT_SCRIPT" ]]; then
    print_error "Conversion script not found at $CONVERT_SCRIPT"
    exit 1
fi

# Help function
show_help() {
    cat << EOF
연구 문서 변환 도구

사용법:
  $0 <마크다운파일> [옵션]

옵션:
  --preview      브라우저에서 미리보기 (기본값)
  --docx         DOCX (Word) 파일로 변환
  --excel        표를 Excel 파일로 추출
  --template     템플릿 선택 (report, legal, presentation)
  --output       출력 파일 경로 지정
  --help, -h     도움말 표시

예시:
  $0 report.md                           # 미리보기
  $0 report.md --docx                    # Word 문서로 변환
  $0 report.md --template legal --docx   # 법률 템플릿으로 Word 변환
  $0 report.md --excel                   # 표를 Excel로 추출

지원되는 템플릿:
  - report: 일반 연구 보고서 (기본값)
  - legal: 법률 문서
  - presentation: 프레젠테이션
EOF
}

# Parse arguments
if [[ $# -eq 0 ]] || [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Get markdown file (first argument)
MARKDOWN_FILE="$1"
shift

# Check if file exists
if [[ ! -f "$MARKDOWN_FILE" ]]; then
    print_error "파일을 찾을 수 없습니다: $MARKDOWN_FILE"
    exit 1
fi

# Check file extension
if [[ "${MARKDOWN_FILE##*.}" != "md" ]]; then
    print_warning "파일 확장자가 .md가 아닙니다. 계속 진행할까요? (y/N)"
    read -r confirm
    if [[ "$confirm" != "y" ]] && [[ "$confirm" != "Y" ]]; then
        print_status "변환을 취소합니다."
        exit 0
    fi
fi

# Run the conversion script
print_status "문서 변환을 시작합니다..."
print_status "파일: $MARKDOWN_FILE"
print_status "의존성을 자동으로 설치하고 변환 스크립트를 실행합니다."

if uv run "$CONVERT_SCRIPT" "$MARKDOWN_FILE" "$@"; then
    print_success "변환이 완료되었습니다!"
else
    print_error "변환 중 오류가 발생했습니다."
    exit 1
fi