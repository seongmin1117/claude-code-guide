# Claude Code Subagents

> 특정 작업에 특화된 전문가 에이전트 정의

## 개요

2025년 7월 추가된 기능. `/agents` 명령어로 커스텀 서브에이전트를 생성할 수 있습니다.

## 기본 사용법

### 에이전트 정의

```markdown
<!-- .claude/agents/code-reviewer.md -->
---
name: code-reviewer
description: 시니어 코드 리뷰어
tools: Read, Grep, Glob, Bash
---

# Code Reviewer Agent

당신은 시니어 코드 리뷰어입니다.

## 리뷰 기준
- 코드 품질
- 보안
- 성능
- 테스트 커버리지
```

### 에이전트 호출

```
# 자동 호출 (Claude가 적합하다고 판단)
코드 리뷰해줘

# Task 도구로 명시적 호출
"code-reviewer 에이전트로 이 파일 리뷰해줘"
```

## Frontmatter 옵션

```yaml
---
name: agent-name          # 에이전트 이름 (필수)
description: 설명          # 에이전트 설명 (필수)
tools: Read, Write, Edit  # 사용 가능한 도구
model: sonnet             # 사용할 모델 (선택)
---
```

### 사용 가능한 도구

| 도구 | 설명 |
|------|------|
| `Read` | 파일 읽기 |
| `Write` | 파일 생성 |
| `Edit` | 파일 편집 |
| `Grep` | 패턴 검색 |
| `Glob` | 파일 패턴 매칭 |
| `Bash` | 쉘 명령어 실행 |
| `WebFetch` | 웹 페이지 조회 |
| `WebSearch` | 웹 검색 |

## 예시 에이전트들

### 1. 테스트 작성 전문가

```markdown
---
name: test-generator
description: 테스트 코드 작성 전문가
tools: Read, Write, Edit, Glob, Bash
---

# Test Generator

테스트 작성 전문가입니다.

## 테스트 원칙
- Given-When-Then 구조
- 단위 테스트 우선
- 엣지 케이스 커버

## 프로세스
1. 대상 클래스 분석
2. 테스트 케이스 도출
3. 테스트 코드 작성
4. 테스트 실행 및 검증
```

### 2. 보안 분석가

```markdown
---
name: security-analyst
description: 보안 취약점 분석 전문가
tools: Read, Grep, Glob
---

# Security Analyst

보안 취약점을 분석합니다.

## 분석 항목
- SQL Injection
- XSS
- CSRF
- 인증/인가 취약점
- 민감 정보 노출

## OWASP Top 10 기준으로 검토
```

### 3. 문서 작성자

```markdown
---
name: doc-writer
description: 기술 문서 작성 전문가
tools: Read, Write, Glob
---

# Documentation Writer

기술 문서를 작성합니다.

## 문서 유형
- API 문서
- README
- 아키텍처 문서
- 사용자 가이드

## 작성 원칙
- 명확하고 간결하게
- 예시 코드 포함
- 다이어그램 활용
```

### 4. 성능 분석가

```markdown
---
name: performance-analyst
description: 성능 분석 및 최적화 전문가
tools: Read, Grep, Glob, Bash
---

# Performance Analyst

성능을 분석하고 최적화합니다.

## 분석 항목
- 시간 복잡도
- 공간 복잡도
- 데이터베이스 쿼리
- N+1 문제
- 캐싱 기회

## 프로파일링
- 병목 지점 식별
- 개선 방안 제시
```

## 디렉토리 구조

```
.claude/
└── agents/
    ├── code-reviewer.md      # 코드 리뷰어
    ├── test-generator.md     # 테스트 작성자
    ├── security-analyst.md   # 보안 분석가
    ├── doc-writer.md         # 문서 작성자
    └── performance-analyst.md # 성능 분석가
```

## Skills vs Agents

| 구분 | Skills | Agents |
|------|--------|--------|
| **호출** | 자연어 (자동) | 명시적/자동 |
| **역할** | 워크플로우 가이드 | 전문가 페르소나 |
| **도구** | 제한 없음 | 명시적 지정 |
| **실행** | 메인 대화 | 서브 프로세스 |

## 에이전트 조합

여러 에이전트를 조합하여 복잡한 작업 수행:

```
1. code-reviewer로 코드 리뷰
2. security-analyst로 보안 검토
3. test-generator로 테스트 추가
4. doc-writer로 문서 업데이트
```

## 참고 자료

- [Claude Code Customization Guide](https://alexop.dev/posts/claude-code-customization-guide-claudemd-skills-subagents/)
- [Claude Code Showcase](https://github.com/ChrisWiles/claude-code-showcase)
