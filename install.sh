#!/bin/bash

# Claude Code 컨텍스트 설정 스크립트
# Usage: ./install.sh [target-directory]

set -e

TARGET_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"

echo "🚀 Claude Code 컨텍스트 설정을 시작합니다..."
echo "   대상 디렉토리: $TARGET_DIR"
echo ""

# 대상 디렉토리 확인
if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ 오류: 디렉토리가 존재하지 않습니다: $TARGET_DIR"
    exit 1
fi

# .claude 디렉토리 생성
CLAUDE_DIR="$TARGET_DIR/.claude"
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/hooks"

echo "📁 디렉토리 구조 생성 완료"

# 템플릿 복사 (확장자 제거)
copy_template() {
    local src="$1"
    local dest="$2"

    if [ -f "$dest" ]; then
        echo "   ⚠️  이미 존재함 (건너뜀): $dest"
    else
        cp "$src" "$dest"
        echo "   ✅ 생성됨: $dest"
    fi
}

echo ""
echo "📄 템플릿 복사 중..."

# 핵심 파일들 (CLAUDE.md는 프로젝트 루트에 배치)
copy_template "$TEMPLATES_DIR/CLAUDE.md.template" "$TARGET_DIR/CLAUDE.md"
copy_template "$TEMPLATES_DIR/.claude/PROGRESS.md.template" "$CLAUDE_DIR/PROGRESS.md"
copy_template "$TEMPLATES_DIR/.claude/CONVENTIONS.md.template" "$CLAUDE_DIR/CONVENTIONS.md"
copy_template "$TEMPLATES_DIR/.claude/settings.json.template" "$CLAUDE_DIR/settings.json"

# 명령어 템플릿
copy_template "$TEMPLATES_DIR/.claude/commands/build.md.template" "$CLAUDE_DIR/commands/build.md"
copy_template "$TEMPLATES_DIR/.claude/commands/test.md.template" "$CLAUDE_DIR/commands/test.md"
copy_template "$TEMPLATES_DIR/.claude/commands/review.md.template" "$CLAUDE_DIR/commands/review.md"

# 에이전트 템플릿
copy_template "$TEMPLATES_DIR/.claude/agents/code-reviewer.md.template" "$CLAUDE_DIR/agents/code-reviewer.md"
copy_template "$TEMPLATES_DIR/.claude/agents/test-generator.md.template" "$CLAUDE_DIR/agents/test-generator.md"

# 기본 훅 스크립트 생성
if [ ! -f "$CLAUDE_DIR/hooks/pre-command-check.sh" ]; then
    cat > "$CLAUDE_DIR/hooks/pre-command-check.sh" << 'EOF'
#!/bin/bash
# Pre-command hook
# 위험한 명령어 실행 전 경고

COMMAND="$1"

# 위험한 패턴 체크
if echo "$COMMAND" | grep -qE "(rm -rf|sudo|chmod 777)"; then
    echo "⚠️ 주의: 위험한 명령어가 감지되었습니다"
    exit 1
fi

exit 0
EOF
    chmod +x "$CLAUDE_DIR/hooks/pre-command-check.sh"
    echo "   ✅ 생성됨: $CLAUDE_DIR/hooks/pre-command-check.sh"
fi

if [ ! -f "$CLAUDE_DIR/hooks/post-edit-check.sh" ]; then
    cat > "$CLAUDE_DIR/hooks/post-edit-check.sh" << 'EOF'
#!/bin/bash
# Post-edit hook
# 파일 편집 후 검증

FILE="$1"

# Java 파일 구문 체크 (선택적)
if [[ "$FILE" == *.java ]]; then
    # javac가 있으면 구문 체크
    if command -v javac &> /dev/null; then
        javac -d /dev/null "$FILE" 2>/dev/null || echo "⚠️ Java 구문 오류 가능"
    fi
fi

exit 0
EOF
    chmod +x "$CLAUDE_DIR/hooks/post-edit-check.sh"
    echo "   ✅ 생성됨: $CLAUDE_DIR/hooks/post-edit-check.sh"
fi

echo ""
echo "✨ 설정 완료!"
echo ""
echo "다음 단계:"
echo "  1. CLAUDE.md 파일을 프로젝트에 맞게 수정하세요"
echo "  2. .claude/PROGRESS.md 파일을 현재 진행 상황에 맞게 수정하세요"
echo "  3. .claude/CONVENTIONS.md 파일을 팀 규칙에 맞게 수정하세요"
echo "  4. git add CLAUDE.md .claude/ && git commit -m 'chore: Claude Code 컨텍스트 설정 추가'"
echo ""
echo "Claude Code 세션에서 'PROGRESS.md 읽고 현재 상황 파악해줘'라고 시작하세요!"
