# Claude Code Skills

> Skills는 Claude Code에게 특정 작업을 처리하는 방법을 가르치는 마크다운 기반 가이드

## 개요

Skills는 슬래시 명령어와 달리 **자연어로 호출**됩니다. Claude가 현재 작업에 적합한 스킬을 자동으로 선택합니다.

## Skills vs Slash Commands

| 구분 | Skills | Slash Commands |
|------|--------|----------------|
| **호출 방식** | 자연어 (Claude가 판단) | 명시적 (`/command`) |
| **실행 위치** | 메인 대화에서 실시간 | 메인 대화에서 |
| **용도** | 복잡한 워크플로우, 가이드 | 반복 작업, 단순 명령 |
| **파일 위치** | `.claude/skills/` | `.claude/commands/` |

## 디렉토리 구조

```
.claude/
├── skills/                    # Skills 디렉토리
│   ├── debugging.md           # 디버깅 스킬
│   ├── code-review.md         # 코드 리뷰 스킬
│   └── testing.md             # 테스트 작성 스킬
└── commands/                  # Slash Commands (별도)
```

## Skill 파일 작성법

### 기본 구조

```markdown
---
name: debugging
description: 버그를 체계적으로 분석하고 해결하는 스킬
triggers:
  - 버그
  - 에러
  - 디버그
  - 문제 해결
---

# 디버깅 스킬

## 목표
버그의 근본 원인을 찾고 수정한다.

## 프로세스

1. **증상 파악**
   - 에러 메시지 확인
   - 재현 조건 파악

2. **원인 분석**
   - 관련 코드 탐색
   - 로그 분석

3. **해결**
   - 수정 코드 작성
   - 테스트로 검증
```

### 메타데이터 (Frontmatter)

| 필드 | 설명 | 필수 |
|------|------|------|
| `name` | 스킬 이름 | ✅ |
| `description` | 스킬 설명 | ✅ |
| `triggers` | 자동 호출 키워드 | 권장 |
| `priority` | 우선순위 (높을수록 먼저) | 선택 |

## 예시 Skills

### 1. 코드 리뷰 스킬

```markdown
---
name: code-review
description: PR 또는 코드 변경사항을 체계적으로 리뷰
triggers:
  - 리뷰
  - PR
  - 코드 검토
---

# 코드 리뷰 스킬

## 체크리스트

### 코드 품질
- [ ] 네이밍이 명확한가?
- [ ] 중복 코드가 없는가?
- [ ] 복잡도가 적절한가?

### 보안
- [ ] 입력 검증이 있는가?
- [ ] 민감 정보 노출이 없는가?

### 테스트
- [ ] 테스트가 충분한가?
- [ ] 엣지 케이스를 커버하는가?
```

### 2. API 설계 스킬

```markdown
---
name: api-design
description: RESTful API 설계 가이드
triggers:
  - API 설계
  - 엔드포인트
  - REST
---

# API 설계 스킬

## 원칙

1. **리소스 중심 URL**
   - Good: `GET /users/{id}`
   - Bad: `GET /getUser?id=1`

2. **적절한 HTTP 메서드**
   - GET: 조회
   - POST: 생성
   - PUT: 전체 수정
   - PATCH: 부분 수정
   - DELETE: 삭제

3. **일관된 응답 형식**
   ```json
   {
     "code": 0,
     "message": "success",
     "data": { }
   }
   ```
```

## 오픈 표준

2025년 10월부터 Agent Skills는 **오픈 표준**이 되어 다음 도구에서도 사용 가능:
- Cursor
- GitHub Copilot
- 기타 AI 코딩 어시스턴트

## 참고 자료

- [Claude Code Customization Guide](https://alexop.dev/posts/claude-code-customization-guide-claudemd-skills-subagents/)
- [Claude Code Skill Factory](https://github.com/alirezarezvani/claude-code-skill-factory)
- [24 Claude Code Tips](https://dev.to/oikon/24-claude-code-tips-claudecodeadventcalendar-52b5)
