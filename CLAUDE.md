# Claude Code Guide - Project Context

> Claude Code를 효율적으로 사용하는 방법을 공유하는 가이드 프로젝트

## Quick Start

```bash
# 진행 상황 확인
cat .claude/PROGRESS.md

# 다른 프로젝트에 적용
./install.sh /path/to/target-project
```

---

## Project Overview

| Item | Value |
|------|-------|
| **Project** | Claude Code 효율적 사용 가이드 |
| **Purpose** | 개발자들이 Claude Code를 프로젝트에 효과적으로 적용할 수 있도록 가이드 및 템플릿 제공 |
| **Target** | Claude Code 초보 ~ 중급 개발자 |

---

## Project Structure

```
claude-code-guide/
├── CLAUDE.md                   # 프로젝트 개요 (이 파일, 자동 로드)
├── README.md                   # 전체 가이드 (설치/사용법)
├── install.sh                  # 자동 설치 스크립트
│
├── .claude/                    # Claude Code 보조 파일
│   └── PROGRESS.md             # 업데이트 이력/로드맵
│
├── templates/                  # 복사해서 사용하는 템플릿
│   ├── CLAUDE.md.template      # 프로젝트 개요 템플릿
│   └── .claude/
│       ├── PROGRESS.md.template
│       ├── CONVENTIONS.md.template
│       ├── settings.json.template
│       ├── commands/
│       └── agents/
│
└── docs/                       # 상세 문서
    ├── changelog/              # 업데이트 내역/패치노트
    ├── features/               # 기능별 상세 가이드
    └── resources/              # 외부 리소스
```

---

## Current Status

| 항목 | 상태 |
|------|------|
| **Version** | v1.0.0 |
| **Last Update** | 2026-01-14 |

**상세 진행 상황**: `.claude/PROGRESS.md` 참조

---

## 콘텐츠 가이드

### README.md (메인 가이드)
- 왜 `.claude/` 디렉토리가 필요한지
- 파일별 역할과 작성법
- 실전 워크플로우
- 흔한 실수와 해결책

### templates/ (템플릿)
- `.template` 확장자로 구분
- 복사 후 프로젝트에 맞게 수정
- `[플레이스홀더]` 형식으로 수정할 부분 표시

### docs/changelog/ (업데이트 내역)
- Claude Code 버전 히스토리
- 주요 업데이트 및 패치노트
- 공식/커뮤니티 체인지로그 링크

### docs/features/ (기능 가이드)
- Skills, MCP, Hooks, Plugins 등
- 각 기능별 상세 사용법
- 예시 코드 포함

### docs/resources/ (외부 리소스)
- 한국어 기술 블로그 모음
- 공식 문서 링크
- 커뮤니티 리소스

---

## Contribution

이 프로젝트에 기여할 때:
1. 실제 프로젝트에서 검증된 패턴만 추가
2. 템플릿은 범용적으로 유지 (특정 프레임워크 종속 X)
3. 한국어 우선, 필요시 영어 병기
4. 새 리소스 발견 시 docs/resources/ 업데이트

---

## Essential Files

| Purpose | File |
|---------|------|
| **Progress** | `.claude/PROGRESS.md` |
| **Main Guide** | `README.md` |
| **Install Script** | `install.sh` |
| **Changelog** | `docs/changelog/README.md` |
| **Features** | `docs/features/README.md` |
| **Korean Resources** | `docs/resources/korean-blogs.md` |
