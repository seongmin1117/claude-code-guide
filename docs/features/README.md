# Claude Code Features Guide

> Claude Code 주요 기능별 상세 가이드

## 기능 목록

| 기능 | 설명 | 문서 |
|------|------|------|
| **Skills** | 자연어로 호출되는 마크다운 가이드 | [skills.md](./skills.md) |
| **MCP** | 외부 도구 연동 프로토콜 | [mcp.md](./mcp.md) |
| **Hooks** | 이벤트 기반 자동화 스크립트 | [hooks.md](./hooks.md) |
| **Plugins** | 기능 패키징 및 배포 시스템 | [plugins.md](./plugins.md) |
| **Commands** | 커스텀 슬래시 명령어 | [commands.md](./commands.md) |
| **Agents** | 전문가 서브에이전트 | [agents.md](./agents.md) |

## 기능 비교

### 커스터마이징 방법

| 방법 | 호출 방식 | 용도 | 복잡도 |
|------|----------|------|--------|
| **CLAUDE.md** | 자동 (세션 시작) | 프로젝트 컨텍스트 | 낮음 |
| **Commands** | 명시적 (`/cmd`) | 반복 작업 | 낮음 |
| **Skills** | 자연어 (자동) | 복잡한 워크플로우 | 중간 |
| **Agents** | 명시적/자동 | 전문가 역할 | 중간 |
| **Hooks** | 자동 (이벤트) | 검증/자동화 | 중간 |
| **MCP** | 도구 호출 | 외부 연동 | 높음 |
| **Plugins** | 패키지 설치 | 기능 배포 | 높음 |

### 파일 위치

```
.claude/
├── CLAUDE.md           # 프로젝트 컨텍스트 (자동 로드)
├── PROGRESS.md         # 진행 상황 (수동 참조)
├── settings.json       # 권한, 훅, MCP 설정
├── commands/           # 슬래시 명령어
│   └── *.md
├── skills/             # 스킬 정의
│   └── *.md
├── agents/             # 서브에이전트
│   └── *.md
└── hooks/              # 훅 스크립트
    └── *.sh
```

## 추천 조합

### 초보자
1. `CLAUDE.md` - 프로젝트 개요
2. `commands/build.md` - 빌드 명령어

### 중급자
1. + `PROGRESS.md` - 진행 상황 관리
2. + `agents/code-reviewer.md` - 코드 리뷰
3. + `settings.json` - 권한 설정

### 고급자
1. + `hooks/` - 자동화 스크립트
2. + `skills/` - 복잡한 워크플로우
3. + `MCP 서버` - 외부 도구 연동

## 학습 순서

```
1. CLAUDE.md 작성법 익히기
       ↓
2. 커스텀 Commands 만들기
       ↓
3. Agents로 전문가 정의
       ↓
4. Hooks로 자동화
       ↓
5. Skills로 워크플로우 정의
       ↓
6. MCP로 외부 연동
       ↓
7. Plugins로 배포
```

## 참고 자료

### 공식
- [Claude Code 공식 문서](https://docs.anthropic.com/ko/docs/claude-code/overview)
- [Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

### 커뮤니티
- [Claude Code Showcase](https://github.com/ChrisWiles/claude-code-showcase)
- [Claude Code Skill Factory](https://github.com/alirezarezvani/claude-code-skill-factory)
- [Awesome Claude](https://awesomeclaude.ai/)
