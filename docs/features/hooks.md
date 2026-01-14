# Claude Code Hooks

> Hooks는 Claude Code의 특정 이벤트 전/후에 자동 실행되는 스크립트

## 개요

Hooks를 사용하면 도구 사용 전후에 검증, 로깅, 자동화 작업을 수행할 수 있습니다.

## Hook 종류

| Hook | 시점 | 용도 |
|------|------|------|
| **PreToolUse** | 도구 실행 전 | 검증, 차단, 로깅 |
| **PostToolUse** | 도구 실행 후 | 검증, 알림, 후처리 |

## 설정 방법

### settings.json

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/pre-bash.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/post-edit.sh"
          }
        ]
      }
    ]
  }
}
```

## Matcher 패턴

| Matcher | 대상 도구 |
|---------|----------|
| `Bash` | 모든 Bash 명령어 |
| `Bash(./gradlew:*)` | gradlew로 시작하는 명령어 |
| `Read` | 파일 읽기 |
| `Edit` | 파일 편집 |
| `Write` | 파일 생성 |
| `*` | 모든 도구 |

## Hook 스크립트 작성

### 기본 구조

```bash
#!/bin/bash
# Hook 스크립트

# 입력 파라미터
TOOL_NAME="$1"
TOOL_ARGS="$2"

# 로직 수행
# ...

# 종료 코드
# 0: 성공 (도구 실행 허용)
# 1: 실패 (도구 실행 차단)
exit 0
```

### 예시: 위험한 명령어 차단

```bash
#!/bin/bash
# .claude/hooks/pre-bash.sh

COMMAND="$1"

# 위험한 패턴 체크
if echo "$COMMAND" | grep -qE "(rm -rf /|sudo rm|chmod 777)"; then
    echo "⚠️ 위험한 명령어가 차단되었습니다: $COMMAND"
    exit 1
fi

exit 0
```

### 예시: Java 파일 구문 검사

```bash
#!/bin/bash
# .claude/hooks/post-edit.sh

FILE="$1"

# Java 파일인 경우 구문 체크
if [[ "$FILE" == *.java ]]; then
    if ! javac -d /tmp -Xlint:none "$FILE" 2>/dev/null; then
        echo "⚠️ Java 구문 오류가 있을 수 있습니다: $FILE"
        # 경고만 하고 차단하지 않음
    fi
fi

exit 0
```

### 예시: 커밋 전 테스트 실행

```bash
#!/bin/bash
# .claude/hooks/pre-git-commit.sh

# 커밋 전 테스트 실행
if ! ./gradlew test --quiet; then
    echo "❌ 테스트 실패. 커밋이 차단되었습니다."
    exit 1
fi

exit 0
```

## 디렉토리 구조

```
.claude/
├── hooks/
│   ├── pre-bash.sh           # Bash 명령어 전처리
│   ├── post-edit.sh          # 파일 편집 후처리
│   ├── pre-git-commit.sh     # Git 커밋 전 검증
│   └── post-write.sh         # 파일 생성 후처리
└── settings.json              # Hook 설정
```

## 실행 권한

```bash
chmod +x .claude/hooks/*.sh
```

## 활용 사례

### 1. 보안 검증
- 위험한 명령어 차단
- 민감 파일 접근 로깅
- 시크릿 노출 방지

### 2. 코드 품질
- 편집 후 린터 실행
- 자동 포맷팅
- 구문 오류 검사

### 3. 워크플로우 자동화
- 파일 생성 시 템플릿 적용
- 커밋 전 테스트 실행
- 변경 사항 알림

### 4. 로깅/모니터링
- 도구 사용 로깅
- 성능 측정
- 사용 통계 수집

## 주의사항

1. **종료 코드**: `exit 0`은 허용, `exit 1`은 차단
2. **실행 권한**: 스크립트에 실행 권한 필요
3. **성능**: 무거운 작업은 비동기로 처리
4. **에러 처리**: 스크립트 오류 시 도구 실행 차단 가능

## 참고 자료

- [Claude Code Showcase](https://github.com/ChrisWiles/claude-code-showcase) - hooks, skills, agents 예시
- [Claude Code Plugins](https://www.anthropic.com/news/claude-code-plugins) - 플러그인으로 hooks 패키징
