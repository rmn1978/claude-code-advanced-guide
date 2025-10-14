#!/bin/bash

# Claude Code Usage Analytics
# Analyzes local usage patterns without any backend

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}📊 Claude Code Usage Analytics${NC}"
echo "=================================="
echo ""

# Configuration
LOG_DIR="$HOME/.claude/logs"
DAYS_TO_ANALYZE=${1:-7}

if [ ! -d "$LOG_DIR" ]; then
    echo -e "${YELLOW}⚠️  No logs found. Start using Claude Code to generate analytics.${NC}"
    exit 0
fi

# Helper function to calculate percentage
calc_percentage() {
    echo "scale=1; $1 * 100 / $2" | bc
}

echo -e "${CYAN}📅 Analysis Period: Last $DAYS_TO_ANALYZE days${NC}"
echo ""

# 1. SESSION ANALYTICS
echo -e "${GREEN}1️⃣  Session Statistics${NC}"
echo "----------------------------"

TOTAL_SESSIONS=$(find "$LOG_DIR" -name "*.log" -mtime -$DAYS_TO_ANALYZE -type f | wc -l | tr -d ' ')
echo "Total Sessions: $TOTAL_SESSIONS"

if [ $TOTAL_SESSIONS -gt 0 ]; then
    AVG_PER_DAY=$(echo "scale=1; $TOTAL_SESSIONS / $DAYS_TO_ANALYZE" | bc)
    echo "Average Sessions/Day: $AVG_PER_DAY"

    # Active days
    ACTIVE_DAYS=$(find "$LOG_DIR" -name "*.log" -mtime -$DAYS_TO_ANALYZE -type f -exec stat -f "%Sm" -t "%Y-%m-%d" {} \; 2>/dev/null | sort -u | wc -l | tr -d ' ')
    echo "Active Days: $ACTIVE_DAYS / $DAYS_TO_ANALYZE"

    # Streak
    echo "Coding Streak: ${ACTIVE_DAYS} days 🔥"
fi

echo ""

# 2. MOST ACTIVE HOURS
echo -e "${GREEN}2️⃣  Most Active Hours${NC}"
echo "----------------------------"

if [ $TOTAL_SESSIONS -gt 0 ]; then
    echo "Hour | Sessions"
    echo "-----|----------"
    find "$LOG_DIR" -name "*.log" -mtime -$DAYS_TO_ANALYZE -type f -exec basename {} \; | \
        cut -d'-' -f1 | cut -c1-2 | sort | uniq -c | sort -rn | head -5 | \
        awk '{printf "%02d:00 | %d (%s)\n", $2, $1, ($1>3?"████":"██")}'
else
    echo "No data available"
fi

echo ""

# 3. FILES MODIFIED
echo -e "${GREEN}3️⃣  Files Modified${NC}"
echo "----------------------------"

# Find recently modified files in common project directories
MODIFIED_FILES=$(find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" -o -name "*.py" -o -name "*.go" -o -name "*.rs" \) -mtime -$DAYS_TO_ANALYZE 2>/dev/null | wc -l | tr -d ' ')

echo "Files modified: $MODIFIED_FILES"

if [ $MODIFIED_FILES -gt 0 ]; then
    echo ""
    echo "Top file types:"
    find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" -o -name "*.py" -o -name "*.go" -o -name "*.rs" \) -mtime -$DAYS_TO_ANALYZE 2>/dev/null | \
        sed 's/.*\.//' | sort | uniq -c | sort -rn | head -5 | \
        awk '{printf "  .%-6s : %d files\n", $2, $1}'
fi

echo ""

# 4. GIT ACTIVITY
echo -e "${GREEN}4️⃣  Git Activity${NC}"
echo "----------------------------"

if [ -d ".git" ]; then
    COMMITS=$(git log --since="$DAYS_TO_ANALYZE days ago" --oneline 2>/dev/null | wc -l | tr -d ' ')
    echo "Commits: $COMMITS"

    if [ $COMMITS -gt 0 ]; then
        echo "Lines added: $(git log --since="$DAYS_TO_ANALYZE days ago" --numstat --pretty="%H" 2>/dev/null | awk 'NF==3 {plus+=$1} END {printf "%d", plus}')"
        echo "Lines deleted: $(git log --since="$DAYS_TO_ANALYZE days ago" --numstat --pretty="%H" 2>/dev/null | awk 'NF==3 {minus+=$2} END {printf "%d", minus}')"
    fi
else
    echo "Not a git repository"
fi

echo ""

# 5. PRODUCTIVITY SCORE
echo -e "${GREEN}5️⃣  Productivity Score${NC}"
echo "----------------------------"

if [ $TOTAL_SESSIONS -gt 0 ]; then
    # Calculate score based on multiple factors
    CONSISTENCY_SCORE=$((ACTIVE_DAYS * 10))
    VOLUME_SCORE=$((MODIFIED_FILES / 10))

    if [ -d ".git" ]; then
        COMMIT_SCORE=$((COMMITS * 5))
    else
        COMMIT_SCORE=0
    fi

    TOTAL_SCORE=$((CONSISTENCY_SCORE + VOLUME_SCORE + COMMIT_SCORE))

    echo "Score: $TOTAL_SCORE points"
    echo ""
    echo "Breakdown:"
    echo "  Consistency: $CONSISTENCY_SCORE pts (${ACTIVE_DAYS} active days)"
    echo "  Volume: $VOLUME_SCORE pts ($MODIFIED_FILES files)"

    if [ -d ".git" ]; then
        echo "  Commits: $COMMIT_SCORE pts ($COMMITS commits)"
    fi

    echo ""

    # Rating
    if [ $TOTAL_SCORE -gt 500 ]; then
        echo "Rating: 🌟🌟🌟🌟🌟 LEGENDARY"
    elif [ $TOTAL_SCORE -gt 300 ]; then
        echo "Rating: 🌟🌟🌟🌟 EXCELLENT"
    elif [ $TOTAL_SCORE -gt 150 ]; then
        echo "Rating: 🌟🌟🌟 GREAT"
    elif [ $TOTAL_SCORE -gt 50 ]; then
        echo "Rating: 🌟🌟 GOOD"
    else
        echo "Rating: 🌟 GETTING STARTED"
    fi
fi

echo ""

# 6. AGENTS USAGE (if available)
echo -e "${GREEN}6️⃣  Agents Usage${NC}"
echo "----------------------------"

if [ -d ".claude/agents" ] || [ -d "$HOME/.claude/agents" ]; then
    AGENT_COUNT=0

    if [ -d ".claude/agents" ]; then
        AGENT_COUNT=$(find .claude/agents -name "*.md" -type f | wc -l | tr -d ' ')
    fi

    if [ -d "$HOME/.claude/agents" ]; then
        GLOBAL_AGENTS=$(find "$HOME/.claude/agents" -name "*.md" -type f | wc -l | tr -d ' ')
        AGENT_COUNT=$((AGENT_COUNT + GLOBAL_AGENTS))
    fi

    echo "Available agents: $AGENT_COUNT"

    if [ $AGENT_COUNT -gt 0 ]; then
        echo ""
        echo "Installed agents:"

        if [ -d ".claude/agents" ]; then
            find .claude/agents -name "*.md" -type f -exec basename {} .md \; | head -10 | awk '{printf "  • %s\n", $1}'
        fi

        if [ -d "$HOME/.claude/agents" ]; then
            find "$HOME/.claude/agents" -name "*.md" -type f -exec basename {} .md \; | head -5 | awk '{printf "  • %s (global)\n", $1}'
        fi
    fi
else
    echo "No agents installed yet"
fi

echo ""

# 7. TIME SAVED ESTIMATION
echo -e "${GREEN}7️⃣  Estimated Time Saved${NC}"
echo "----------------------------"

if [ $TOTAL_SESSIONS -gt 0 ]; then
    # Conservative estimate: 30 minutes saved per session
    MINUTES_SAVED=$((TOTAL_SESSIONS * 30))
    HOURS_SAVED=$(echo "scale=1; $MINUTES_SAVED / 60" | bc)

    echo "Time saved: ~$HOURS_SAVED hours"
    echo "That's $(echo "scale=1; $HOURS_SAVED / 8" | bc) work days!"

    # Cost savings (assuming $50/hour developer rate)
    COST_SAVED=$(echo "scale=0; $HOURS_SAVED * 50" | bc)
    echo "Estimated value: \$$COST_SAVED"
fi

echo ""

# 8. RECOMMENDATIONS
echo -e "${GREEN}8️⃣  Recommendations${NC}"
echo "----------------------------"

if [ $ACTIVE_DAYS -lt 3 ]; then
    echo "💡 Use Claude Code more consistently for better results"
fi

if [ $AGENT_COUNT -lt 3 ]; then
    echo "💡 Create more specialized agents for your workflows"
    echo "   Run: ./scripts/generate-agent.sh"
fi

if [ ! -f "CLAUDE.md" ]; then
    echo "💡 Create a CLAUDE.md file to improve Claude's context"
    echo "   Template: templates/CLAUDE.md"
fi

if [ $MODIFIED_FILES -gt 100 ]; then
    echo "🎉 Great job! You're using Claude Code effectively"
fi

echo ""

# 9. EXPORT OPTION
echo -e "${CYAN}💾 Export Options${NC}"
echo "----------------------------"
echo ""
echo "1) Export to JSON"
echo "2) Export to CSV"
echo "3) Generate HTML report"
echo "4) Skip export"
echo ""

read -p "Select option (1-4): " EXPORT_CHOICE

case $EXPORT_CHOICE in
    1)
        OUTPUT_FILE="claude-analytics-$(date +%Y%m%d).json"
        cat > "$OUTPUT_FILE" << EOF
{
  "period_days": $DAYS_TO_ANALYZE,
  "total_sessions": $TOTAL_SESSIONS,
  "active_days": $ACTIVE_DAYS,
  "files_modified": $MODIFIED_FILES,
  "productivity_score": $TOTAL_SCORE,
  "agents_count": $AGENT_COUNT,
  "estimated_hours_saved": $HOURS_SAVED,
  "generated_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
        echo -e "${GREEN}✅ Exported to $OUTPUT_FILE${NC}"
        ;;
    2)
        OUTPUT_FILE="claude-analytics-$(date +%Y%m%d).csv"
        cat > "$OUTPUT_FILE" << EOF
Metric,Value
Period (days),$DAYS_TO_ANALYZE
Total Sessions,$TOTAL_SESSIONS
Active Days,$ACTIVE_DAYS
Files Modified,$MODIFIED_FILES
Productivity Score,$TOTAL_SCORE
Agents Count,$AGENT_COUNT
Hours Saved,$HOURS_SAVED
EOF
        echo -e "${GREEN}✅ Exported to $OUTPUT_FILE${NC}"
        ;;
    3)
        OUTPUT_FILE="claude-analytics-$(date +%Y%m%d).html"
        cat > "$OUTPUT_FILE" << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Claude Code Analytics</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; border-bottom: 3px solid #4CAF50; padding-bottom: 10px; }
        .metric { display: flex; justify-content: space-between; padding: 15px; margin: 10px 0; background: #f9f9f9; border-radius: 5px; }
        .metric-label { font-weight: bold; color: #555; }
        .metric-value { color: #4CAF50; font-size: 1.2em; }
        .score { font-size: 2em; text-align: center; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 Claude Code Analytics Report</h1>
        <p>Generated: $(date)</p>
        <p>Period: Last $DAYS_TO_ANALYZE days</p>

        <div class="metric">
            <span class="metric-label">Total Sessions</span>
            <span class="metric-value">$TOTAL_SESSIONS</span>
        </div>

        <div class="metric">
            <span class="metric-label">Active Days</span>
            <span class="metric-value">$ACTIVE_DAYS</span>
        </div>

        <div class="metric">
            <span class="metric-label">Files Modified</span>
            <span class="metric-value">$MODIFIED_FILES</span>
        </div>

        <div class="metric">
            <span class="metric-label">Agents Installed</span>
            <span class="metric-value">$AGENT_COUNT</span>
        </div>

        <div class="metric">
            <span class="metric-label">Estimated Time Saved</span>
            <span class="metric-value">~$HOURS_SAVED hours</span>
        </div>

        <div class="score">
            <strong>Productivity Score</strong><br>
            $TOTAL_SCORE points
        </div>
    </div>
</body>
</html>
EOF
        echo -e "${GREEN}✅ Exported to $OUTPUT_FILE${NC}"
        echo "   Open with: open $OUTPUT_FILE"
        ;;
    *)
        echo "Skipping export"
        ;;
esac

echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${GREEN}Analysis complete! Keep coding! 🚀${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
