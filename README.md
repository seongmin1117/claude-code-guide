# Claude Code 효율적 사용 가이드

> Claude Code를 처음 시작하는 개발자를 위한 실전 가이드

[![GitHub](https://img.shields.io/badge/GitHub-claude--code--guide-blue)](https://github.com/seongmin1117/claude-code-guide)

## 왜 이 가이드가 필요한가?

Claude Code는 강력하지만, **컨텍스트 없이 사용하면 매 세션마다 처음부터 시작**합니다.
이 가이드는 실전에서 검증된 방법을 공유합니다.

---

## 목차

- [핵심 개념](#핵심-개념-claude-디렉토리)
- [Quick Start](#quick-start-5분)
- [파일별 역할과 작성법](#파일별-역할과-작성법)
- [실전 워크플로우](#실전-워크플로우)
- [효과적인 컨텍스트 관리 팁](#효과적인-컨텍스트-관리-팁)
- [흔한 실수와 해결책](#흔한-실수와-해결책)
- [상세 문서](#상세-문서)

---

## Claude Code 설치

> 공식 설치 방법 (2025년 기준)

### macOS / Linux / WSL (권장)
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

### Homebrew
```bash
brew install --cask claude-code
```

### Windows PowerShell
```powershell
irm https://claude.ai/install.ps1 | iex
```

### Windows WinGet
```cmd
winget install Anthropic.ClaudeCode
```

> ⚠️ **참고**: npm 설치 방식(`npm install -g @anthropic-ai/claude-code`)은 deprecated되었습니다.

---

## 핵심 개념: `.claude/` 디렉토리

Claude Code는 프로젝트 루트의 **`CLAUDE.md`** 파일을 **자동으로 읽습니다**.
이 파일에 프로젝트 컨텍스트를 잘 정리해두면, Claude가 프로젝트를 즉시 이해합니다.

```
your-project/
├── CLAUDE.md                   # 핵심: 프로젝트 개요 (자동 로드)
├── .claude/                    # Claude Code 설정 (Git에 포함)
│   ├── settings.json           # 권한/훅 설정
│   ├── commands/               # 커스텀 슬래시 명령어
│   │   └── build.md
│   └── agents/                 # 전문가 에이전트 정의
│       └── code-reviewer.md
├── .claude/PROGRESS.md         # 진행 상황 추적 (선택)
└── src/
```

> **Note**: `CLAUDE.md`는 프로젝트 루트 또는 `.claude/` 디렉토리에 위치할 수 있습니다.

---

## Quick Start (5분)

### 1단계: 설치 스크립트 사용

```bash
# 이 저장소 클론
git clone https://github.com/seongmin1117/claude-code-guide.git

# 프로젝트에 적용
./claude-code-guide/install.sh /path/to/your-project
```

### 2단계: 수동 설정

```bash
# 기본 구조 생성
mkdir -p .claude/commands .claude/agents

# 템플릿 복사 (이 저장소에서)
cp templates/.claude/CLAUDE.md.template CLAUDE.md
cp templates/.claude/PROGRESS.md.template .claude/PROGRESS.md
```

### 3단계: 프로젝트에 맞게 수정

```bash
# CLAUDE.md 편집 - 프로젝트 정보 입력
# [프로젝트명], [기술스택] 등 플레이스홀더 수정
```

### 4단계: Git에 추가

```bash
git add CLAUDE.md .claude/
git commit -m "chore: Claude Code 컨텍스트 설정 추가"
```

---

## 파일별 역할과 작성법

### 1. CLAUDE.md (필수, 자동 로드)

**역할**: 프로젝트의 "뇌" - Claude가 세션 시작 시 자동으로 읽는 파일

**포함해야 할 내용**:

| 섹션 | 설명 | 예시 |
|------|------|------|
| **Quick Start** | 3줄 이내 실행법 | `./gradlew bootRun` |
| **Project Overview** | 한줄 요약 | "MFA/OIDC Provider (Spring Boot 4.0)" |
| **Project Structure** | 디렉토리 트리 | `src/main/java/...` |
| **Current Status** | Phase, 진행률 | "Phase 5: 테스트 완료" |
| **Architecture** | 레이어 규칙 | "domain → application → api" |
| **Key Technologies** | 주의사항 | "Spring Boot 4.0: Lambda DSL 필수" |
| **Essential Files** | 중요 파일 경로 | "docs/API.md" |

**핵심 원칙**:
- **간결하게**: Claude가 토큰을 효율적으로 사용하도록
- **구조화**: 테이블, 코드블록 활용
- **최신 유지**: 프로젝트 변경 시 업데이트

### 2. PROGRESS.md (권장)

**역할**: 세션 간 연속성 유지

**왜 필요한가?**
- Claude는 세션이 끝나면 컨텍스트를 잃음
- 새 세션 시작 시 "PROGRESS.md 먼저 읽어"라고 하면 바로 이어서 작업

**포함해야 할 내용**:

```markdown
## Quick Status
| 항목 | 상태 |
|------|------|
| **Current Phase** | Phase 3 🔄 진행 중 |
| **Tests** | 245개 ✅ |
| **Last Completed** | 인증 API 구현 |
| **Next Up** | 테스트 작성 |

## Phase Summary
| Phase | 내용 | 상태 |
|-------|------|------|
| Phase 1 | 초기 설정 | ✅ 완료 |
| Phase 2 | 도메인 모델 | ✅ 완료 |
| Phase 3 | API 구현 | 🔄 진행 중 |
```

### 3. settings.json (선택)

**역할**: 권한 제어 및 자동화 훅

```json
{
  "permissions": {
    "allow": [
      "Bash(./gradlew:*)",
      "Read(**/src/**)",
      "Edit(**/src/**)"
    ],
    "deny": [
      "Bash(rm -rf:*)",
      "Read(.env)",
      "Edit(.git/**)"
    ]
  }
}
```

### 4. commands/ (선택)

**역할**: 커스텀 슬래시 명령어 (/build, /test 등)

```markdown
---
description: Build project with Gradle
allowed-tools: Bash, Read, TodoWrite
---

# Gradle Build Command

$ARGUMENTS (default: build)

./gradlew $ARGUMENTS --console=plain
```

**사용법**: `/build test` → Gradle test 실행

### 5. agents/ (선택)

**역할**: 전문가 페르소나 정의 (코드 리뷰어, 테스트 작성자 등)

---

## 실전 워크플로우

### 새 세션 시작할 때

```
# 첫 번째 메시지
PROGRESS.md 읽고 현재 진행 상황 파악해줘
```

Claude가 자동으로:
1. `CLAUDE.md` 로드 (자동)
2. `PROGRESS.md` 읽기
3. 현재 컨텍스트 파악

### 작업 중

```
# 구체적인 요청
Phase 3의 AuthController 테스트 작성해줘

# 규칙 참조
CONVENTIONS.md 참고해서 커밋 메시지 작성해줘
```

### 세션 종료 전

```
# 진행 상황 업데이트
PROGRESS.md에 오늘 작업 내용 반영해줘
```

---

## 효과적인 컨텍스트 관리 팁

### 1. 계층적 정보 구조

```
CLAUDE.md (고수준)
    ├── 프로젝트 개요
    ├── 아키텍처 규칙
    └── 참조: "상세는 docs/API.md 참고"

docs/API.md (저수준)
    └── 구체적인 API 스펙
```

Claude는 필요할 때 참조 문서를 찾아 읽습니다.

### 2. Phase 기반 관리

복잡한 프로젝트는 Phase로 나누어 관리:

```markdown
| Phase | 내용 | 상태 |
|-------|------|------|
| Phase 1 | 초기 설정 | ✅ 완료 |
| Phase 2 | 도메인 모델 | ✅ 완료 |
| Phase 3 | API 구현 | 🔄 진행 중 |
```

### 3. 완료 기록 보관

Phase 완료 시 상세 기록을 별도 파일로:

```
docs/history/
├── PHASE_1_COMPLETED.md
├── PHASE_2_COMPLETED.md
└── PHASE_3_COMPLETED.md
```

### 4. 기술 스택 주의사항 명시

```markdown
## Key Technologies

### Spring Boot 4.0 주의사항
- HTTP Service Clients (`@HttpExchange`) 사용
- Jackson 3.0 (spring.jackson 프로퍼티 변경)
- Spring Security 7.0 (Lambda DSL 필수)
```

---

## 흔한 실수와 해결책

### 실수 1: CLAUDE.md가 너무 길다

**문제**: 토큰 낭비, 핵심 정보 희석

**해결**: 요약 + 참조 구조
```markdown
## Architecture
Clean Architecture 레이어 규칙 준수
- 상세: `docs/ARCHITECTURE.md` 참조
```

### 실수 2: PROGRESS.md 업데이트 안 함

**문제**: 다음 세션에서 처음부터 다시 설명

**해결**: 세션 종료 전 습관화
```
작업 끝났어. PROGRESS.md 업데이트해줘
```

### 실수 3: 빌드/테스트 명령어 누락

**문제**: Claude가 빌드 방법을 몰라서 질문

**해결**: Quick Start 섹션 필수
```markdown
## Quick Start
./gradlew build           # 전체 빌드
./gradlew test            # 테스트 실행
./gradlew bootRun         # 서버 실행
```

### 실수 4: 민감 정보 포함

**문제**: API 키, 비밀번호가 CLAUDE.md에 노출

**해결**: settings.json에서 차단
```json
{
  "permissions": {
    "deny": ["Read(.env)", "Read(**/secrets/**)"]
  }
}
```

---

## 상세 문서

이 가이드 외에도 상세한 문서를 제공합니다:

| 카테고리 | 내용 | 경로 |
|----------|------|------|
| **Changelog** | Claude Code 버전 히스토리, 패치노트 | [docs/changelog/](./docs/changelog/) |
| **Features** | Skills, MCP, Hooks, Plugins 상세 가이드 | [docs/features/](./docs/features/) |
| **Resources** | 한국어 블로그, 공식 문서 링크 | [docs/resources/](./docs/resources/) |

### 기능별 가이드

| 기능 | 설명 | 문서 |
|------|------|------|
| **Skills** | 자연어로 호출되는 마크다운 가이드 | [skills.md](./docs/features/skills.md) |
| **MCP** | 외부 도구 연동 프로토콜 | [mcp.md](./docs/features/mcp.md) |
| **Hooks** | 이벤트 기반 자동화 스크립트 | [hooks.md](./docs/features/hooks.md) |
| **Plugins** | 기능 패키징 및 배포 시스템 | [plugins.md](./docs/features/plugins.md) |
| **Commands** | 커스텀 슬래시 명령어 | [commands.md](./docs/features/commands.md) |
| **Agents** | 전문가 서브에이전트 | [agents.md](./docs/features/agents.md) |

---

## 템플릿 파일

이 가이드와 함께 제공되는 템플릿:

```
templates/
├── .claude/
│   ├── CLAUDE.md.template       # 프로젝트 개요
│   ├── PROGRESS.md.template     # 진행 상황 추적
│   ├── CONVENTIONS.md.template  # 코딩 규칙
│   ├── settings.json.template   # 권한 설정
│   ├── commands/
│   │   ├── build.md.template    # 빌드 명령어
│   │   ├── test.md.template     # 테스트 명령어
│   │   └── review.md.template   # 코드 리뷰
│   └── agents/
│       ├── code-reviewer.md.template   # 코드 리뷰어
│       └── test-generator.md.template  # 테스트 작성자
```

---

## 정리: Claude Code가 잘 작동하려면

| 필수 | 권장 | 선택 |
|------|------|------|
| `CLAUDE.md` | `PROGRESS.md` | `settings.json` |
| - 프로젝트 개요 | - 현재 Phase | - 권한 제어 |
| - 디렉토리 구조 | - 완료/진행 상태 | - 자동화 훅 |
| - 빌드 명령어 | - 다음 작업 | - 커스텀 명령어 |
| - 아키텍처 규칙 | | - 전문가 에이전트 |

**최소 시작**: `CLAUDE.md` 하나만 잘 작성해도 효과적입니다.

---

## 참고 자료

### 공식 문서
- [Claude Code 공식 문서](https://code.claude.com/docs/en/overview)
- [GitHub 저장소](https://github.com/anthropics/claude-code)
- [Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

### 한국어 리소스
- [하이퍼리즘 기술 블로그](https://tech.hyperithm.com/claude_code_guides)
- [SK Devocean](https://devocean.sk.com/blog/techBoardDetail.do?id=167718)
- [더 많은 한국어 리소스](./docs/resources/korean-blogs.md)

---

## 기여

버그 리포트, 기능 제안, PR 환영합니다!

- 실제 프로젝트에서 검증된 패턴만 추가
- 템플릿은 범용적으로 유지 (특정 프레임워크 종속 X)
- 한국어 우선, 필요시 영어 병기

---

## 라이선스

MIT License
