# Claude Code MCP (Model Context Protocol)

> MCP 서버로 Claude Code의 기능을 확장하여 외부 도구 및 데이터 소스와 연동

## 개요

MCP(Model Context Protocol)는 Claude Code가 외부 시스템과 통신할 수 있게 해주는 프로토콜입니다.

## 공식 문서

- [MCP 연동 가이드](https://code.claude.com/docs/en/mcp)
- [Anthropic MCP 문서](https://docs.anthropic.com/ko/docs/claude-code/mcp)

## MCP 서버 종류

### 공식 MCP 서버

| 서버 | 용도 |
|------|------|
| **filesystem** | 파일 시스템 접근 |
| **github** | GitHub API 연동 |
| **postgres** | PostgreSQL 데이터베이스 |
| **sqlite** | SQLite 데이터베이스 |
| **puppeteer** | 브라우저 자동화 |
| **slack** | Slack 연동 |

### 인기 커뮤니티 MCP 서버

| 서버 | 용도 | 링크 |
|------|------|------|
| **context7** | 라이브러리 문서 조회 | - |
| **sequential** | 복잡한 분석 | - |
| **magic** | UI 컴포넌트 생성 | - |
| **playwright** | 브라우저 E2E 테스트 | - |

## MCP 서버 설정

### 설정 파일 위치

```bash
# 전역 설정
~/.claude/settings.json

# 프로젝트별 설정
.claude/settings.json
```

### 설정 예시

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/dir"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      }
    }
  }
}
```

## MCP Prompts (슬래시 명령어)

MCP 서버는 슬래시 명령어로 사용할 수 있는 프롬프트를 제공합니다:

```
/mcp__servername__promptname
```

예시:
```
/mcp__github__create-issue
/mcp__postgres__query
```

## MCP 서버 개발

### 기본 구조

```typescript
import { Server } from "@modelcontextprotocol/sdk/server/index.js";

const server = new Server({
  name: "my-mcp-server",
  version: "1.0.0"
});

// 도구 정의
server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: "my_tool",
      description: "My custom tool",
      inputSchema: {
        type: "object",
        properties: {
          query: { type: "string" }
        }
      }
    }
  ]
}));

// 도구 실행
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (request.params.name === "my_tool") {
    // 도구 로직
    return { content: [{ type: "text", text: "Result" }] };
  }
});
```

## 활용 사례

### 1. 데이터베이스 연동
```
MCP postgres 서버로 DB 쿼리 실행
→ 스키마 분석, 데이터 조회
```

### 2. GitHub 자동화
```
MCP github 서버로 이슈/PR 관리
→ 이슈 생성, PR 리뷰, 코드 검색
```

### 3. 브라우저 자동화
```
MCP puppeteer/playwright로 웹 테스트
→ E2E 테스트, 스크린샷, 성능 측정
```

### 4. 외부 API 연동
```
커스텀 MCP 서버로 사내 API 연동
→ Jira, Confluence, 내부 도구
```

## MCP 마켓플레이스

- [MCP Market](https://mcpmarket.com/) - MCP 서버 및 도구 마켓
- [Claude Code Slash Commands Skill](https://mcpmarket.com/tools/skills/claude-code-slash-commands)

## 참고 자료

- [Model Context Protocol 공식](https://modelcontextprotocol.io/)
- [MCP GitHub 저장소](https://github.com/modelcontextprotocol)
- [Claude Code MCP 문서](https://code.claude.com/docs/en/mcp)
