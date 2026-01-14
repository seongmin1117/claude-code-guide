# Claude Code Changelog & Release Notes

> Claude Code 업데이트 내역 및 패치노트 정리

## 공식 소스

| 소스 | 설명 | 링크 |
|------|------|------|
| **GitHub Releases** | 공식 릴리즈 노트 | [releases](https://github.com/anthropics/claude-code/releases) |
| **CHANGELOG.md** | 상세 변경 이력 | [CHANGELOG.md](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md) |
| **Anthropic 공식** | 릴리즈 노트 | [Release Notes](https://support.claude.com/en/articles/12138966-release-notes) |

## 커뮤니티 소스

| 소스 | 설명 | 링크 |
|------|------|------|
| **ClaudeLog** | 커뮤니티 체인지로그 | [claudelog.com](https://claudelog.com/claude-code-changelog/) |
| **ClaudeFast** | 버전 히스토리 | [claudefa.st](https://claudefa.st/blog/guide/changelog) |
| **@ClaudeCodeLog** | X(트위터) 업데이트 봇 | [@ClaudeCodeLog](https://x.com/ClaudeCodeLog) |

---

## 주요 버전 히스토리

### 2026년

#### v2.1.x (2026년 1월)
- **v2.1.4**: 최신 안정 버전
- **v2.1.0**: 1,096개 커밋 포함 메이저 업데이트
  - 터미널 입력 개선
  - Skills 시스템 전면 개편
  - 성능 최적화

### 2025년

2025년 한 해 동안 **176회 업데이트** 배포 - 베타에서 v2.0까지 급속 발전

#### 주요 마일스톤

| 시기 | 버전/기능 | 내용 |
|------|----------|------|
| **2025.02** | 출시 | Claude Code 베타 출시 (터미널 기반 AI 코딩 도구) |
| **2025.04** | Claude Opus 4 | 새 모델 적용 |
| **2025.06** | Claude Opus 4.1 | 성능 및 기능 개선 |
| **2025.07** | Custom Subagents | `/agents` 명령어로 커스텀 서브에이전트 생성 |
| **2025.08** | Statusline | `/statusline`으로 터미널 프롬프트 커스터마이징 |
| **2025.10** | Plugins | 플러그인 시스템 공개 베타 |
| **2025.10** | Agent Skills | 스킬 시스템 오픈 표준화 |
| **2025.12** | v2.0 | 안정 버전 2.0 릴리즈 |

---

## 주요 기능 추가 타임라인

### Thinking Mode (2025)
```
사용법: "think", "think harder", "ultrathink"
```
- 복잡한 문제에 대한 깊은 사고 모드
- `--ultrathink` 플래그로 최대 깊이 분석

### Custom Slash Commands (2025)
- `.claude/commands/` 디렉토리의 마크다운 파일
- 슬래시 명령어로 자동 등록
- `$ARGUMENTS` 키워드로 파라미터 전달

### Custom Subagents (2025.07)
- `/agents` 명령어로 시작
- 특정 작업에 특화된 서브에이전트 정의
- `.claude/agents/` 디렉토리에 저장

### Plugins (2025.10)
- `/plugin` 명령어로 설치
- 슬래시 명령어, 에이전트, MCP 서버, 훅 패키징
- 공개 베타

### Agent Skills (2025.10)
- 마크다운 기반 가이드
- 자연어로 자동 호출
- Cursor, GitHub Copilot과 호환되는 오픈 표준

---

## 보안 패치

| 버전 | 내용 |
|------|------|
| 2025.xx | Bash 명령어 처리 시 명령어 주입 취약점 수정 |
| 2025.xx | tree-sitter 파싱 트리 미해제로 인한 WASM 메모리 누수 수정 |

---

## 버전 확인 방법

```bash
claude --version
```

---

## 참고 자료

- [Claude Code 2025 Summary](https://medium.com/@joe.njenga/claude-code-2025-summary-from-launch-to-beast-timeline-features-full-breakdown-45e5f3d8d5ff) - 2025년 전체 타임라인 정리
- [Claude Code 2.1 Changes](https://medium.com/@joe.njenga/claude-code-2-1-is-here-i-tested-all-16-new-changes-dont-miss-this-update-ea9ca008dab7) - 2.1 버전 16가지 변경사항
- [Reflections from CHANGELOG](https://dev.to/oikon/reflections-of-claude-code-from-changelog-833) - 체인지로그 분석
