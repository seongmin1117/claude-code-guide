# Claude Code Custom Commands

> 슬래시 명령어로 반복 작업을 자동화

## 개요

`.claude/commands/` 디렉토리에 마크다운 파일을 만들면 자동으로 슬래시 명령어로 등록됩니다.

## 기본 사용법

### 파일 생성

```markdown
<!-- .claude/commands/build.md -->
---
description: 프로젝트 빌드
allowed-tools: Bash, Read
---

# Build Command

./gradlew build
```

### 명령어 호출

```
/build
```

## 파일 구조

### Frontmatter (메타데이터)

```yaml
---
description: 명령어 설명 (필수)
allowed-tools: Bash, Read, Write, Edit  # 허용 도구
argument-hint: [arg1] [arg2]  # 인자 힌트
---
```

### 본문

마크다운 형식으로 Claude에게 전달할 지시사항 작성

## $ARGUMENTS 변수

명령어 호출 시 전달된 인자를 받을 수 있습니다:

```markdown
---
description: 특정 테스트 실행
---

# Test Command

실행할 테스트: $ARGUMENTS

./gradlew test --tests "$ARGUMENTS"
```

사용:
```
/test AuthServiceTest
```

## 동적 정보 삽입

`!` 접두사로 쉘 명령어 결과를 삽입:

```markdown
# Build Command

## Current Status
- Branch: !`git branch --show-current`
- Last commit: !`git log -1 --oneline`

## Task
$ARGUMENTS
```

## 예시 명령어들

### /build

```markdown
---
description: Gradle 빌드
allowed-tools: Bash, Read, TodoWrite
argument-hint: [task] build|test|clean
---

# Build

Task: $ARGUMENTS (default: build)

./gradlew ${ARGUMENTS:-build} --console=plain
```

### /commit

```markdown
---
description: 변경사항 커밋
allowed-tools: Bash, Read
---

# Commit

1. 변경 사항 확인
2. 적절한 커밋 메시지 생성
3. 커밋 실행

!`git status --short`
!`git diff --stat`
```

### /review

```markdown
---
description: 코드 리뷰
allowed-tools: Read, Grep, Glob
argument-hint: [target] staged|HEAD|file
---

# Code Review

대상: $ARGUMENTS

체크리스트:
- 아키텍처 규칙
- 보안 취약점
- 테스트 커버리지
```

### /fix-issue

```markdown
---
description: GitHub 이슈 수정
allowed-tools: Bash, Read, Write, Edit
argument-hint: <issue-number>
---

# Fix Issue #$ARGUMENTS

1. 이슈 내용 확인: !`gh issue view $ARGUMENTS`
2. 관련 코드 분석
3. 수정 사항 구현
4. 테스트 작성
5. PR 생성
```

## 디렉토리 구조

```
.claude/
└── commands/
    ├── build.md      → /build
    ├── test.md       → /test
    ├── review.md     → /review
    └── deploy.md     → /deploy
```

## 팀 공유

`.claude/commands/`를 Git에 커밋하면 팀 전체가 동일한 명령어 사용:

```bash
git add .claude/commands/
git commit -m "chore: 팀 공용 Claude 명령어 추가"
```

## 내장 명령어

| 명령어 | 설명 |
|--------|------|
| `/help` | 도움말 |
| `/clear` | 대화 초기화 |
| `/compact` | 대화 압축 |
| `/config` | 설정 |
| `/cost` | 비용 확인 |
| `/doctor` | 진단 |
| `/init` | 초기화 |
| `/login` | 로그인 |
| `/logout` | 로그아웃 |
| `/mcp` | MCP 관리 |
| `/memory` | 메모리 관리 |
| `/model` | 모델 선택 |
| `/permissions` | 권한 관리 |
| `/pr-comments` | PR 코멘트 |
| `/review` | 코드 리뷰 |
| `/statusline` | 상태줄 설정 |
| `/terminal-setup` | 터미널 설정 |
| `/vim` | Vim 모드 |

## 참고 자료

- [Claude Code CLI Cheatsheet](https://shipyard.build/blog/claude-code-cheat-sheet/)
- [Claude Code Developer Cheatsheet](https://awesomeclaude.ai/code-cheatsheet)
