# Claude Code Plugins

> Plugins는 슬래시 명령어, 에이전트, MCP 서버, 훅을 하나로 패키징한 확장 시스템

## 개요

2025년 10월 공개 베타로 출시. 단일 명령어로 여러 기능을 한 번에 설치할 수 있습니다.

## 공식 발표

- [Customize Claude Code with plugins](https://www.anthropic.com/news/claude-code-plugins)

## 플러그인 구성 요소

플러그인은 다음 조합을 포함할 수 있습니다:

| 구성 요소 | 설명 |
|----------|------|
| **Slash Commands** | 커스텀 슬래시 명령어 |
| **Subagents** | 전문가 에이전트 |
| **MCP Servers** | 외부 도구 연동 |
| **Hooks** | 이벤트 기반 자동화 |

## 플러그인 설치

```bash
# Claude Code 내에서
/plugin install <plugin-name>

# 또는 URL로
/plugin install https://github.com/user/claude-plugin
```

## 플러그인 관리

```bash
/plugin list           # 설치된 플러그인 목록
/plugin update         # 플러그인 업데이트
/plugin remove <name>  # 플러그인 제거
```

## 플러그인 만들기

### 디렉토리 구조

```
my-plugin/
├── plugin.json              # 플러그인 메타데이터
├── commands/                # 슬래시 명령어
│   └── my-command.md
├── agents/                  # 서브에이전트
│   └── my-agent.md
├── hooks/                   # 훅 스크립트
│   └── pre-commit.sh
└── mcp/                     # MCP 서버 설정
    └── config.json
```

### plugin.json

```json
{
  "name": "my-awesome-plugin",
  "version": "1.0.0",
  "description": "My awesome Claude Code plugin",
  "author": "Your Name",
  "repository": "https://github.com/user/my-plugin",
  "components": {
    "commands": ["commands/"],
    "agents": ["agents/"],
    "hooks": ["hooks/"],
    "mcp": ["mcp/"]
  },
  "dependencies": {
    "node": ">=18.0.0"
  }
}
```

## 공개 플러그인

### 인기 플러그인

| 플러그인 | 설명 |
|----------|------|
| **git-workflow** | Git 워크플로우 자동화 |
| **test-runner** | 테스트 실행 및 분석 |
| **doc-generator** | 문서 자동 생성 |
| **security-scanner** | 보안 취약점 스캔 |

### 플러그인 마켓플레이스

- [MCP Market](https://mcpmarket.com/) - MCP 및 플러그인 마켓

## 플러그인 개발 팁

### 1. 단일 책임
- 하나의 플러그인은 하나의 목적
- 너무 많은 기능 포함 X

### 2. 문서화
- README.md 필수
- 사용 예시 포함

### 3. 버전 관리
- Semantic Versioning 사용
- CHANGELOG 유지

### 4. 테스트
- 플러그인 기능 테스트
- 다양한 환경에서 검증

## 플러그인 vs 직접 설정

| 구분 | 플러그인 | 직접 설정 |
|------|----------|----------|
| **설치** | `/plugin install` 한 줄 | 파일별 수동 생성 |
| **업데이트** | `/plugin update` | 수동 업데이트 |
| **공유** | 저장소 공유 | 파일 복사 |
| **커스터마이징** | 제한적 | 완전 자유 |

## 주의사항

1. **신뢰할 수 있는 소스**: 공식/검증된 플러그인만 설치
2. **권한 검토**: 플러그인이 요청하는 권한 확인
3. **버전 호환성**: Claude Code 버전과 호환성 확인
4. **보안**: hooks, MCP 서버의 코드 검토

## 참고 자료

- [Claude Code Plugins 공식 발표](https://www.anthropic.com/news/claude-code-plugins)
- [Claude Code Showcase](https://github.com/ChrisWiles/claude-code-showcase)
