#!/usr/bin/env bash
# Structural lint for the flow plugin. Runs from the repo, or via a
# --plugin-dir/symlinked copy (it resolves symlinks back to the real repo).
#
# The MakeTimeFlow server repo is optional: when present, rule 7 verifies every
# tool named in mcp-tools.md still exists server-side. When absent (CI, a
# contributor's machine) that rule reports SKIP rather than failing.
# Override its location with MAKETIMEFLOW_SERVER=/path/to/maketimeflow-server.
set -euo pipefail

# Resolve this script's real location even when invoked through a symlink.
SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
cd "$DIR/../.."   # repo root
S=skills/flow
fail=0

# 1. Required plugin files exist
for f in .claude-plugin/plugin.json .claude-plugin/marketplace.json .mcp.json README.md LICENSE; do
  test -f "$f" || { echo "MISSING $f"; fail=1; }
done

# 2. Required skill files exist
for f in SKILL.md README.md .lint.sh \
  references/aligned-action.md references/mcp-tools.md references/success-story-coaching.md \
  references/plan-my-day.md references/weekly-wrap.md references/triage.md \
  assets/templates/README.md \
  assets/templates/horizons/long-term.md assets/templates/horizons/medium-term.md assets/templates/horizons/short-term.md \
  assets/templates/foundations/values.md assets/templates/foundations/strengths.md assets/templates/foundations/relationships.md; do
  test -f "$S/$f" || { echo "MISSING $S/$f"; fail=1; }
done

# 3. Every manifest parses, and declares the names the install command depends on
if command -v python3 >/dev/null 2>&1; then
  python3 - <<'PY' || fail=1
import json, sys
ok = True
def load(p):
    global ok
    try:
        with open(p) as f: return json.load(f)
    except Exception as e:
        print(f"INVALID JSON {p}: {e}"); ok = False; return {}

plugin = load(".claude-plugin/plugin.json")
market = load(".claude-plugin/marketplace.json")
mcp    = load(".mcp.json")

if plugin.get("name") != "flow":
    print('plugin.json: name must be "flow" (drives /flow:<skill>)'); ok = False
if market.get("name") != "maketimeflow":
    print('marketplace.json: name must be "maketimeflow" (drives flow@maketimeflow)'); ok = False
entries = market.get("plugins", [])
if not any(e.get("name") == "flow" and e.get("source") == "./" for e in entries):
    print('marketplace.json: needs a plugin entry name "flow" with source "./"'); ok = False

# version stays unset during the beta so the commit SHA is the version and every
# push reaches installed users. Going explicit is a deliberate release-cadence
# change — make it consciously, not by accident.
if "version" in plugin or any("version" in e for e in entries):
    print("NOTE: explicit version set — remember to bump it on every user-visible change")

server = mcp.get("mcpServers", {}).get("maketimeflow")
if not server:
    print('.mcp.json: missing the "maketimeflow" server'); ok = False
else:
    if server.get("type") != "http":
        print('.mcp.json: maketimeflow must be type "http"'); ok = False
    if server.get("url") != "https://my.maketimeflow.com/mcp":
        print('.mcp.json: maketimeflow url must be the production endpoint'); ok = False

sys.exit(0 if ok else 1)
PY
else
  echo "WARN: python3 not found — manifest JSON not validated"
fi

# 4. Frontmatter on every skill
grep -q '^name: flow$' "$S/SKILL.md" || { echo "SKILL.md: bad name"; fail=1; }
grep -q '^description: ' "$S/SKILL.md" || { echo "SKILL.md: no description"; fail=1; }
for door in setup triage plan-my-day wrap; do
  d="skills/$door/SKILL.md"
  test -f "$d" || { echo "MISSING $d"; fail=1; continue; }
  grep -q "^name: $door$" "$d" || { echo "$d: bad name"; fail=1; }
  grep -q '^description: ' "$d" || { echo "$d: no description"; fail=1; }
  # Doors are typed front doors only — the umbrella skill owns model invocation.
  grep -q '^disable-model-invocation: true$' "$d" || { echo "$d: must disable model invocation"; fail=1; }
done

# 5. Every references/*.md named in SKILL.md or a door resolves
for src in "$S/SKILL.md" skills/setup/SKILL.md skills/triage/SKILL.md skills/plan-my-day/SKILL.md skills/wrap/SKILL.md; do
  test -f "$src" || continue
  for ref in $(grep -oE 'references/[a-z-]+\.md' "$src" | sort -u); do
    test -f "$S/$ref" || { echo "$src links missing $ref"; fail=1; }
  done
done

# 6. Templates carry the unfilled sentinel
for f in horizons/long-term horizons/medium-term horizons/short-term foundations/values foundations/strengths foundations/relationships; do
  head -1 "$S/assets/templates/$f.md" | grep -q '^<!-- flow:template -->$' || { echo "no sentinel: $f"; fail=1; }
done

# 7. Every MCP tool the skill names is documented, and still exists server-side.
#    The server-side half is skipped when the server repo isn't on this machine.
TOOLS="get_temporal_context list_tasks assess_capacity check_fit create_task update_task
       time_spent_summary stalled_tasks complete_task cancel_task set_waiting_for add_followup
       move_bucket start_timer get_foundations list_stories read_story create_story update_story
       update_story_stage update_story_dates update_values update_strengths update_relationships
       list_reflections create_reflection"
SERVER="${MAKETIMEFLOW_SERVER:-$HOME/code/maketime/maketimeflow-server}"
for t in $TOOLS; do
  grep -q "\`$t\`" "$S/references/mcp-tools.md" || { echo "tool not documented: $t"; fail=1; }
done
if [ -d "$SERVER/app/mcp/tools" ]; then
  for t in $TOOLS; do
    test -f "$SERVER/app/mcp/tools/${t}_tool.rb" || { echo "tool missing server-side: $t"; fail=1; }
  done
else
  echo "SKIP: server repo not found at $SERVER — tool existence unverified"
fi

# 8. Public repo hygiene, scoped to what reaches a user's Claude.
#
#    Every .md under skills/ is loaded into someone's context, so a private repo
#    path there is worse than a disclosure — it is a broken instruction, sending
#    Claude after files the user does not have. Cite help.maketimeflow.com
#    instead; a local corpus may be preferred when present, never named by path.
#    Repo infrastructure (this script, CONTRIBUTING.md) is exempt by scope, not
#    by exception: it never ships into a conversation, and a contributor does
#    need to be told where the optional server-repo check looks.
INTERNAL='staging\.maketimeflow|flow-(staging|prod[0-9]|worker|db|load)\b|maketimeflow-(knowledge|server)|canon/methodology'
if grep -rniE "$INTERNAL" --include='*.md' skills/ 2>/dev/null; then
  echo "private path or internal host in shipped skill content"; fail=1
fi
# Root-level docs are read by people, not loaded as context — only hosts and the
# private knowledge repo are out of bounds there.
if grep -riE 'staging\.maketimeflow|flow-(staging|prod[0-9]|worker|db|load)\b|maketimeflow-knowledge' \
     --include='*.md' --include='*.json' --include='*.yml' . --exclude-dir=skills --exclude-dir=.git 2>/dev/null; then
  echo "internal host or private repo referenced in a root doc"; fail=1
fi

[ $fail -eq 0 ] && echo "flow plugin lint: OK" || { echo "flow plugin lint: FAIL"; exit 1; }
