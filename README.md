# Claude Code Starter Kit

다양한 Claude Code 템플릿과 도구 모음입니다.

## 📦 Available Templates

### 1. Research Assistant
AI 기반 연구 분석 도구 모음

**설치 방법:**
```bash
# npx degit 사용 (권장)
npx degit sungjunlee/claude-code-starter-kit/research-assistant my-research

# 또는 Git Clone 사용
git clone https://github.com/sungjunlee/claude-code-starter-kit.git
cd claude-code-starter-kit/research-assistant
```

**포함된 에이전트:**
- research-analyst: 종합적인 연구 조사
- search-specialist: 특정 정보 검색
- trend-analyst: 트렌드 분석 및 예측
- competitive-analyst: 경쟁사 분석
- market-researcher: 시장 분석
- data-researcher: 데이터 분석
- korean-legal-expert: 한국 법률 전문가

### 2. Python Development
🐍 현대적인 Python 개발 환경 템플릿 (uv + ruff + Claude Code hooks)

**설치 방법:**
```bash
# npx degit 사용 (권장)
npx degit sungjunlee/claude-code-starter-kit/python-dev my-python-project

# 또는 Git Clone 사용
git clone https://github.com/sungjunlee/claude-code-starter-kit.git
cd claude-code-starter-kit/python-dev
```

**주요 특징:**
- **uv**: 초고속 패키지 매니저 (pip 대비 10-100배 빠름)
- **ruff**: 초고속 린터/포매터 (flake8 대비 150배 빠름)
- **Claude Code hooks**: 자동 포매팅, 테스팅, 품질 검사
- **VS Code 통합**: 완전한 IDE 지원
- **pytest + mypy**: 현대적 테스팅 및 타입 체킹

**포함된 에이전트:**
- python-expert: Python 전문가 (코드 리뷰, 아키텍처, 베스트 프랙티스)
- test-runner: 테스트 전문가 (테스트 전략, 디버깅, 커버리지)
- package-manager: 패키지 관리 전문가 (의존성 관리, 환경 설정)

**커스텀 명령어:**
- `/test`: 종합적인 테스트 실행 (커버리지 포함)
- `/lint`: 코드 품질 검사 (ruff, mypy, bandit)
- `/format`: 자동 코드 포매팅
- `/deps`: 의존성 관리 (add, remove, update)

---

## 🚀 Quick Start

### Prerequisites
- Node.js 16+ 
- npm 또는 yarn
- Git (선택사항)

### Installation

각 템플릿은 독립적으로 설치 가능합니다:

```bash
# 원하는 템플릿 선택하여 설치
npx degit sungjunlee/claude-code-starter-kit/[template-name] [your-project-name]

# 예시 - 연구 분석 도구
npx degit sungjunlee/claude-code-starter-kit/research-assistant my-research-project

# 예시 - Python 개발 환경
npx degit sungjunlee/claude-code-starter-kit/python-dev my-python-project
```

## 🛠️ Development

새로운 템플릿 추가하기:

1. 프로젝트 루트에 새 디렉토리 생성
2. 템플릿 파일 추가
3. 해당 디렉토리에 README.md 작성
4. 이 파일에 템플릿 정보 추가

## 📝 License

MIT

## 🤝 Contributing

Pull requests are welcome! 새로운 템플릿이나 개선사항을 제안해주세요.