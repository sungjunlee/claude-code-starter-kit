# Claude Code 설치 가이드 (Windows)

개발 경험이 없는 분들도 쉽게 따라할 수 있는 Claude Code 설치 및 설정 가이드입니다.

## 🎯 Claude Code란?

Claude Code는 AI 코딩 어시스턴트로, VSCode에서 코드 작성을 도와주는 강력한 도구입니다.

## 📋 준비사항

- Windows 10 이상
- 인터넷 연결
- 관리자 권한

## ⚠️ 설치 방법 선택

아래 두 가지 방법 중 하나를 선택하세요:

1. **[방법 A: 일반 사용자용](#방법-a-일반-사용자용-windows-terminal--powershell)** - 개인 컴퓨터 사용자
2. **[방법 B: 회사/제한된 환경용](#방법-b-회사제한된-환경용-cmd--git-bash)** - 회사 컴퓨터나 PowerShell 제한이 있는 환경

---

## 방법 A: 일반 사용자용 (Windows Terminal + PowerShell)

### A-1단계: Windows Terminal 설치 (Windows 10 사용자)

Windows 11은 기본 설치되어 있습니다. Windows 10 사용자만 설치하세요.

1. **Microsoft Store에서 설치**
   - Microsoft Store 열기
   - "Windows Terminal" 검색
   - "설치" 버튼 클릭

### A-2단계: PowerShell 실행 정책 변경

PowerShell 스크립트 실행을 허용하기 위한 설정입니다.

1. **Windows Terminal을 관리자 권한으로 실행**
   - 시작 버튼 우클릭
   - "Windows Terminal (관리자)" 선택

2. **실행 정책 변경**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
   - Y 또는 A를 입력하여 확인

### A-3단계: Git 설치

Git은 버전 관리 도구로, 많은 개발 도구에서 필요합니다.

```powershell
winget install -e --id Git.Git
```

### A-4단계: Node.js 설치

```powershell
winget install -e --id OpenJS.NodeJS
```

설치 후 Windows Terminal을 닫고 다시 열어서 확인:
```powershell
node --version
npm --version
```

### A-5단계: Python 패키지 관리자(uv) 설치

```powershell
winget install --id=astral-sh.uv -e
```

### A-6단계: VSCode 설치

```powershell
winget install -e --id Microsoft.VisualStudioCode
```

### A-7단계: Claude Code 설치

1. **Claude Code CLI 설치**
   ```powershell
   irm https://claude.ai/install.ps1 | iex
   ```

2. **VSCode 확장 프로그램 설치**
   - VSCode 실행
   - 좌측 확장 프로그램 아이콘 클릭
   - "Claude Code" 검색 후 설치

3. **설치 확인**
   ```powershell
   claude doctor
   ```

---

## 방법 B: 회사/제한된 환경용 (CMD + Git Bash)

PowerShell 실행이 제한된 환경에서 사용하는 방법입니다.

### B-1단계: CMD를 관리자 권한으로 실행

1. **명령 프롬프트를 관리자로 실행**
   - Windows 키 + R
   - "cmd" 입력
   - Ctrl + Shift + Enter (관리자 권한)

### B-2단계: Git 설치 (Git Bash 포함)

Git for Windows는 Git Bash라는 Unix 스타일 터미널을 함께 제공합니다.

```cmd
winget install -e --id Git.Git
```

설치 중 옵션:
- "Git Bash Here" 옵션 체크
- "Use Git from Windows Command Prompt" 선택
- 나머지는 기본값 사용

### B-3단계: Node.js 설치

```cmd
winget install -e --id OpenJS.NodeJS
```

설치 후 CMD를 닫고 다시 열어서 확인:
```cmd
node --version
npm --version
```

### B-4단계: Python 패키지 관리자(uv) 설치

```cmd
winget install --id=astral-sh.uv -e
```

### B-5단계: VSCode 설치 및 설정

1. **VSCode 설치**
   ```cmd
   winget install -e --id Microsoft.VisualStudioCode
   ```

2. **VSCode 기본 터미널을 CMD로 변경**
   - VSCode 실행
   - `F1` 또는 `Ctrl + Shift + P`
   - "Terminal: Select Default Profile" 입력
   - "Command Prompt" 선택

### B-6단계: Claude Code 설치 (Git Bash 사용)

1. **Git Bash 실행**
   - 시작 메뉴에서 "Git Bash" 검색하여 실행
   - 또는 원하는 폴더에서 우클릭 → "Git Bash Here"

2. **Claude Code 설치 스크립트 실행**
   ```bash
   curl -fsSL https://claude.ai/install.sh | sh
   ```

3. **npm 전역 경로 설정** (CMD에서 실행)
   ```cmd
   setx PATH "%PATH%;%APPDATA%\npm"
   ```
   
4. **VSCode 확장 프로그램 설치**
   - VSCode 실행
   - 좌측 확장 프로그램 아이콘 클릭
   - "Claude Code" 검색 후 설치

5. **설치 확인** (CMD 재시작 후)
   ```cmd
   claude doctor
   ```

### B-7단계: VSCode에서 Git Bash 사용 (선택사항)

Git Bash를 VSCode 터미널로 사용하려면:

1. VSCode에서 `F1` 또는 `Ctrl + Shift + P`
2. "Terminal: Select Default Profile" 입력
3. "Git Bash" 선택

---

## ✅ Claude Code 인증

설치 방법과 관계없이 동일합니다.

1. **Claude Code 실행**
   ```
   claude
   ```
   
2. **인증 방법 선택**
   - Anthropic Console 계정: OAuth 인증 진행
   - Claude Pro/Max 구독: Claude.ai 계정으로 로그인

## 🔧 문제 해결

### 방법 A (PowerShell) 문제 해결

#### PowerShell 실행 정책 오류
```
이 시스템에서 스크립트를 실행할 수 없으므로...
```
- 관리자 권한으로 실행했는지 확인
- Group Policy로 제한된 경우 → 방법 B 사용

#### Windows Terminal 특수문자 깨짐
- 설정 → 프로필 → PowerShell → 모양 → 글꼴을 "Cascadia Code"로 변경

### 방법 B (CMD/Git Bash) 문제 해결

#### "명령을 찾을 수 없음" 오류
- CMD를 재시작
- PATH 환경변수 확인:
  ```cmd
  echo %PATH%
  ```
- npm 경로가 없으면 수동 추가:
  ```cmd
  setx PATH "%PATH%;%APPDATA%\npm"
  ```

#### Git Bash에서 한글 깨짐
- Git Bash 창 우클릭 → Options → Text → Locale을 "ko_KR"로 변경
- Font를 "Consolas" 또는 "D2Coding"으로 변경

### 공통 문제

#### 설치 실패
- 관리자 권한 확인
- 인터넷 연결 확인
- 회사 프록시/방화벽 설정 확인
- Windows Defender 실시간 보호 일시 중지

#### Claude Code 실행 안됨
- 설치 후 터미널 재시작 필수
- 컴퓨터 재부팅 시도

## 💡 사용 팁

### VSCode 단축키
- **Claude Code 시작**: `Ctrl + Esc`
- **터미널 열기**: `` Ctrl + ` `` (백틱)
- **명령 팔레트**: `F1` 또는 `Ctrl + Shift + P`

### Claude Code 명령어
- **기본 실행**: `claude`
- **권한 확인 없이 실행**: `claude --dangerously-skip-permissions`
- **비용 확인**: `claude /cost`
- **컨텍스트 초기화**: `claude /clear`

### 효율적인 사용법
- 프로젝트 폴더에서 VSCode 열기 → 터미널에서 `claude` 실행
- 여러 프로젝트는 별도 터미널 탭에서 실행
- `.claude/commands/` 폴더에 커스텀 명령어 추가 가능

## 🎯 연구 분석 에이전트 소개

Claude Code에는 다양한 전문 에이전트가 있습니다:

- **research-analyst**: 종합적인 연구 조사
- **search-specialist**: 특정 정보 검색
- **trend-analyst**: 트렌드 분석 및 예측
- **competitive-analyst**: 경쟁사 분석
- **market-researcher**: 시장 분석
- **data-researcher**: 데이터 분석
- **korean-legal-expert**: 한국 법률 전문가

필요에 따라 적절한 에이전트를 선택하여 사용하세요!

## 📄 문서 변환 기능

연구 결과를 전문적인 문서 형태로 변환할 수 있습니다.

### 지원하는 변환 형식

- **DOCX**: Word 문서 형식 (편집 가능)
- **PDF**: 인쇄용 문서 형식 (브라우저를 통해)
- **Excel**: 표 데이터를 스프레드시트로 추출

### 사용 방법

#### 1. 슬래시 명령어 (Claude Code 내에서)

```
/export-docx report.md                      # Word 문서로 변환
/export-pdf legal-analysis.md               # PDF 변환용 브라우저 미리보기
/export-excel market-data.md                # 표를 Excel로 추출
```

템플릿을 지정하여 다양한 스타일 적용:

```
/export-docx report.md --template legal     # 법률 문서 템플릿
/export-pdf analysis.md --template report   # 연구 보고서 템플릿
```

#### 2. 독립 실행 스크립트

**Windows:**
```cmd
convert.bat report.md --docx
convert.bat report.md --preview --template legal
convert.bat report.md --excel
```

**Mac/Linux:**
```bash
./convert.sh report.md --docx
./convert.sh report.md --preview --template legal
./convert.sh report.md --excel
```

### 문서 템플릿

연구 목적에 맞는 3가지 전문 템플릿 제공:

#### 📊 **report** (기본 템플릿)
- 연구 보고서 및 분석 문서용
- 깔끔한 비즈니스 스타일
- 데이터 시각화 최적화
- 통계 정보 및 차트에 적합

#### ⚖️ **legal**  
- 법률 문서 및 판례 분석용
- 한국 법률 문서 표준 형식
- 조문 인용 및 판례 참조 스타일
- 각주 및 메타데이터 강화

#### 🎯 **presentation**
- 발표용 슬라이드 형식
- 키 포인트 강조
- 시각적 임팩트 최대화
- 인쇄 시 A4 가로 최적화

### 메타데이터 활용

마크다운 파일 상단에 메타데이터를 추가하면 자동으로 문서에 반영됩니다:

```yaml
---
title: 시장 분석 보고서
author: 김연구
date: 2024-01-15
case_number: 2024민5678  # 법률 문서의 경우
court: 서울중앙지방법원     # 법률 문서의 경우
agents: research-analyst, market-researcher
---

# 보고서 내용 시작
```

### 자동 의존성 설치

모든 변환 도구는 uv를 활용하여 필요한 Python 패키지를 자동으로 설치합니다. 별도 설치 과정이 불필요합니다.

### PDF 변환 팁

1. `/export-pdf` 또는 `--preview` 옵션으로 브라우저를 엽니다
2. **Ctrl+P** (Windows) 또는 **Cmd+P** (Mac)를 눌러 인쇄 대화상자를 엽니다
3. "대상"에서 **"PDF로 저장"**을 선택합니다
4. "기타 설정"에서 여백을 "최소"로 설정하면 더 예쁜 결과를 얻을 수 있습니다

## 📚 추가 도움말

- 문제 발생 시: [GitHub Issues](https://github.com/anthropics/claude-code/issues)
- 공식 문서: [Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code)
- 커뮤니티: [Discord](https://discord.gg/claude-code)

---

이제 Claude Code를 사용할 준비가 되었습니다! 🎉