@echo off
REM Quick document conversion script for research assistant (Windows)
REM Uses uv to run the conversion script with automatic dependency installation

setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "CONVERT_SCRIPT=%SCRIPT_DIR%scripts\convert.py"

REM Color codes for Windows
set "RED=[31m"
set "GREEN=[32m"
set "YELLOW=[33m"
set "BLUE=[34m"
set "NC=[0m"

REM Check if uv is installed
uv --version >nul 2>&1
if errorlevel 1 (
    echo %RED%[ERROR]%NC% uv is not installed. Please install it first:
    echo   winget install astral-sh.uv
    echo   or visit: https://docs.astral.sh/uv/getting-started/installation/
    exit /b 1
)

REM Check if convert script exists
if not exist "%CONVERT_SCRIPT%" (
    echo %RED%[ERROR]%NC% Conversion script not found at %CONVERT_SCRIPT%
    exit /b 1
)

REM Show help if no arguments or help requested
if "%~1"=="" goto :show_help
if "%~1"=="--help" goto :show_help
if "%~1"=="-h" goto :show_help
if "%~1"=="/?" goto :show_help

REM Get markdown file (first argument)
set "MARKDOWN_FILE=%~1"

REM Check if file exists
if not exist "%MARKDOWN_FILE%" (
    echo %RED%[ERROR]%NC% 파일을 찾을 수 없습니다: %MARKDOWN_FILE%
    exit /b 1
)

REM Run the conversion script
echo %BLUE%[INFO]%NC% 문서 변환을 시작합니다...
echo %BLUE%[INFO]%NC% 파일: %MARKDOWN_FILE%
echo %BLUE%[INFO]%NC% 의존성을 자동으로 설치하고 변환 스크립트를 실행합니다.

(cd /d "%SCRIPT_DIR%" && uv run "%CONVERT_SCRIPT%" %*)
if errorlevel 1 (
    echo %RED%[ERROR]%NC% 변환 중 오류가 발생했습니다.
    exit /b 1
) else (
    echo %GREEN%[SUCCESS]%NC% 변환이 완료되었습니다!
)

goto :eof

:show_help
echo.
echo 연구 문서 변환 도구 (Windows)
echo.
echo 사용법:
echo   %~n0 ^<마크다운파일^> [옵션]
echo.
echo 옵션:
echo   --preview      브라우저에서 미리보기 (기본값)
echo   --docx         DOCX (Word) 파일로 변환
echo   --excel        표를 Excel 파일로 추출
echo   --template     템플릿 선택 (report, legal, presentation)
echo   --output       출력 파일 경로 지정
echo   --help, -h, /? 도움말 표시
echo.
echo 예시:
echo   %~n0 report.md                           # 미리보기
echo   %~n0 report.md --docx                    # Word 문서로 변환
echo   %~n0 report.md --template legal --docx   # 법률 템플릿으로 Word 변환
echo   %~n0 report.md --excel                   # 표를 Excel로 추출
echo.
echo 지원되는 템플릿:
echo   - report: 일반 연구 보고서 (기본값)
echo   - legal: 법률 문서
echo   - presentation: 프레젠테이션
echo.