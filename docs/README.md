# Claude Code Guide - Documentation

> Claude Code 관련 문서 모음

## 문서 구조

```
docs/
├── README.md              # 이 파일
├── changelog/             # 업데이트 내역
│   └── README.md          # 버전 히스토리, 패치노트
├── features/              # 기능별 가이드
│   ├── README.md          # 기능 개요
│   ├── skills.md          # Skills 시스템
│   ├── mcp.md             # MCP 연동
│   ├── hooks.md           # Hooks 자동화
│   ├── plugins.md         # Plugins 시스템
│   ├── commands.md        # 커스텀 명령어
│   └── agents.md          # 서브에이전트
└── resources/             # 외부 리소스
    ├── README.md          # 리소스 개요
    └── korean-blogs.md    # 한국어 블로그/가이드
```

## 카테고리별 안내

### [Changelog](./changelog/)
- Claude Code 버전 히스토리
- 주요 업데이트 및 패치노트
- 공식/커뮤니티 체인지로그 링크

### [Features](./features/)
- Skills: 자연어로 호출되는 마크다운 가이드
- MCP: 외부 도구 연동 프로토콜
- Hooks: 이벤트 기반 자동화
- Plugins: 기능 패키징 및 배포
- Commands: 커스텀 슬래시 명령어
- Agents: 전문가 서브에이전트

### [Resources](./resources/)
- 한국어 기술 블로그 모음
- 공식 문서 링크
- 커뮤니티 리소스

---

## 기여 안내

### 문서 추가

1. 적절한 카테고리 선택
2. 마크다운 파일 생성
3. 해당 README에 링크 추가
4. PR 제출

### 문서 스타일

- 한국어 우선, 필요시 영어 병기
- 코드 예시 포함
- 링크는 테이블 형식 선호
- 짧고 명확하게

---

## 업데이트 주기

| 카테고리 | 주기 |
|----------|------|
| Changelog | 주요 버전 출시 시 |
| Features | 새 기능 출시 시 |
| Resources | 새 리소스 발견 시 |
