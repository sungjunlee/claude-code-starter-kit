#!/bin/bash
# Deep Research - 스마트 인터뷰를 통한 종합 연구 분석

# Colors for better UX
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Current date and time variables
CURRENT_DATE=$(date '+%Y-%m-%d')
CURRENT_YEAR=$(date '+%Y')
CURRENT_TIME=$(date '+%H:%M:%S')
CURRENT_DATETIME=$(date '+%Y-%m-%d %H:%M:%S %Z')

print_header() {
    echo -e "${BLUE}=== 🔍 Deep Research Assistant ===${NC}"
    echo -e "${BLUE}스마트 인터뷰를 통한 전문 연구 분석${NC}"
    echo ""
}

print_step() {
    echo -e "${GREEN}[$1/7]${NC} $2"
}

print_thinking() {
    echo -e "${YELLOW}🤔 $1${NC}"
}

print_header

# Display current date for context
echo -e "${GREEN}현재 날짜: $CURRENT_DATE${NC}"
echo ""

# Step 1: 기본 연구 주제 입력
print_step 1 "연구 주제를 입력해주세요"
echo -n "연구하고 싶은 주제나 질문: "
read -r research_topic

if [ -z "$research_topic" ]; then
    echo -e "${RED}연구 주제가 입력되지 않았습니다.${NC}"
    exit 1
fi

echo ""
print_thinking "연구 주제 분석 중..."

# Step 2-6: 스마트 인터뷰 진행
echo ""
print_step 2 "연구 목적을 구체화해보겠습니다"

# 연구 목적 파악
echo "이 연구의 주된 목적은 무엇인가요?"
echo "1) 법적 쟁점 분석 및 해결방안 모색"
echo "2) 시장/산업 동향 분석 및 전망"
echo "3) 경쟁사/비교 분석"
echo "4) 규제/정책 변화 영향 분석"
echo "5) 기타 (직접 입력)"
echo -n "선택 (1-5): "
read -r purpose_choice

case $purpose_choice in
    1) research_purpose="법적 쟁점 분석" ;;
    2) research_purpose="시장 동향 분석" ;;
    3) research_purpose="경쟁 분석" ;;
    4) research_purpose="규제 정책 분석" ;;
    5) 
        echo -n "연구 목적을 직접 입력하세요: "
        read -r research_purpose
        ;;
    *) research_purpose="종합 분석" ;;
esac

# Step 3: 대상 및 범위
echo ""
print_step 3 "연구 대상과 범위를 명확히 하겠습니다"
echo -n "주요 분석 대상 (회사명, 법령명, 시장 등): "
read -r research_target

echo -n "지역적 범위 (한국, 글로벌, 특정 지역): "
read -r geographic_scope

# Step 4: 시간적 범위
echo ""
print_step 4 "시간적 범위를 설정하겠습니다"
echo -n "분석하고자 하는 기간 (예: 최근 3년, 2020-2024): "
read -r time_scope

# Step 5: 중요도 및 우선순위
echo ""
print_step 5 "중요하게 다뤄야 할 측면을 선택해주세요"
echo "가장 중요한 3가지를 선택하세요 (쉼표로 구분):"
echo "1) 법적 근거 및 판례"
echo "2) 최신 동향 및 변화"
echo "3) 실무적 적용방안"
echo "4) 위험요소 및 대응방안"
echo "5) 비용 및 경제적 영향"
echo "6) 해외 사례 및 벤치마킹"
echo -n "선택 (예: 1,3,4): "
read -r priorities

# Step 6: 최종 활용 목적
echo ""
print_step 6 "연구 결과의 활용 목적을 확인하겠습니다"
echo "1) 내부 의사결정 자료"
echo "2) 클라이언트 보고서"
echo "3) 법적 검토 의견서"
echo "4) 사업 계획서"
echo "5) 학술/연구 목적"
echo -n "선택 (1-5): "
read -r usage_purpose

# Step 7: 종합 분석 실행
echo ""
print_step 7 "종합 분석을 시작합니다"
print_thinking "최적의 에이전트 조합을 선택하고 있습니다..."

# 연구 목적에 따른 에이전트 자동 선택
case $purpose_choice in
    1) agents="korean-legal-expert,research-analyst" ;;
    2) agents="market-researcher,trend-analyst,data-researcher" ;;
    3) agents="competitive-analyst,market-researcher" ;;
    4) agents="korean-legal-expert,trend-analyst,research-analyst" ;;
    *) agents="research-analyst,search-specialist" ;;
esac

print_thinking "선택된 에이전트: $agents"
echo ""

# 종합 연구 프롬프트 생성
research_prompt="# 종합 연구 분석 요청

## 연구 시점
- **현재 날짜**: $CURRENT_DATE
- **기준 연도**: $CURRENT_YEAR
- **분석 시작**: $CURRENT_DATETIME

## 연구 개요
- **주제**: $research_topic
- **목적**: $research_purpose
- **대상**: $research_target
- **범위**: $geographic_scope, $time_scope
- **우선순위**: $priorities
- **활용목적**: $usage_purpose

## 요구사항
1. 위 정보를 바탕으로 체계적이고 종합적인 연구를 수행해주세요
2. 모든 주장에 대해 신뢰할 수 있는 출처를 제시해주세요
3. 실무에 바로 활용 가능한 수준의 상세한 분석을 제공해주세요
4. 한국의 법적, 사업적 환경을 고려한 현실적인 관점을 포함해주세요
5. 웹 검색 시 현재 연도($CURRENT_YEAR)를 포함하여 최신 정보를 우선적으로 수집해주세요
6. 2년 이상 오래된 자료는 명시적으로 날짜를 표기해주세요

## 출력 형식
- 체계적인 구조의 마크다운 문서
- 각 섹션별 명확한 결론과 권고사항
- 참조 가능한 출처 링크 포함
- 즉시 활용 가능한 실무적 조언

위 요구사항에 따라 전문적이고 포괄적인 연구 보고서를 작성해주세요."

echo "=== 연구 분석 시작 ==="
echo ""
echo "$research_prompt"
echo ""
echo "=== 분석 완료 후 문서 변환을 진행합니다 ==="
echo "💡 Tip: 분석이 완료되면 자동으로 Word 문서로 변환됩니다."