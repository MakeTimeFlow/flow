# Aligned Action — the framework, in this skill's terms

Aligned Action cascades three **horizon success stories** into daily task selection: the **long-term** (5-year vision) sets direction, the **medium-term** (quarterly) is the bridge, and the **short-term** (weekly) is the live one that plan-my-day and WRAP read every day. **Foundations** — values, strengths, relationships — ground the choices, so the week serves what actually matters.

Full method: **https://help.maketimeflow.com** — the Aligned Action Framework, Time Horizons, the Task Trust System, and the Flourishing Map are all published there. This file is the operational summary, not a replacement. If a local methodology corpus is present on this machine, prefer it.

## Where intention lives

The ledger lives **in MakeTimeFlow**, read and written through the MCP:

- **Stories**: `list_stories` (no args) returns the current stack — per horizon, the active story or an in-window draft written ahead. `read_story` for full content + the watcher's evaluation feedback. `update_story` writes (whole body). Past stories are kept by the server automatically — **there is no archiving step**; history is the record.
- **Foundations**: `get_foundations` returns values (ordered), strengths, and relationships in one call; `update_values` / `update_strengths` / `update_relationships` write them.

Trust the tool descriptions for parameters and semantics — this skill carries the workflow, not the schema.

## Detect-and-prompt (unfilled stories)

Before a playbook leans on a horizon, check it's actually written. A story is **unfilled** if it is **missing from the current stack** OR **its content still reads as the untouched starter template** (the fill-in prompts intact, nothing personal in it — judge from the `read_story` content, and let a very low `word_count` raise suspicion). For an unfilled story a playbook needs, **stop and prompt**: offer the coaching in `success-story-coaching.md`, or — first run only — the legacy migration below.

## First run — migrate the legacy workspace

If the MakeTimeFlow stories/foundations are unfilled AND a legacy local `flow/` workspace exists with filled files, offer to migrate:

1. Read the local `horizons/*.md` and `foundations/*.md` that are filled (a file is filled unless missing or its first line is still `<!-- flow:template -->`).
2. Draft the migration in chat — which horizon gets which content, the values list in priority order, the strengths/relationships text.
3. On approval: `update_story` per horizon, `update_values` (the FULL ordered list), `update_strengths`, `update_relationships`.
4. Suggest the user retire the local workspace afterward (it no longer participates in the loop); leave the files untouched otherwise.

## Posture — draft, confirm, write

Reads are free. Every **write** is drafted in chat, approved, then executed. MakeTimeFlow writes pass the MCP `mcp:write` consent on top. Ledger-specific: stories are **whole-body** writes (read first; send the entire rewritten document; never append a second copy); `update_values` **replaces the full list** (call `get_foundations` first and include everything the user keeps); **committing a story (`update_story_stage`) happens only on the user's explicit ask** — writing content never commits or activates anything.

## Foundations are read-if-present (v1)

v1 does **not** coach foundations authoring. It reads `get_foundations` so the weekly story can name the values it serves, and it prompts when a needed foundation is empty. Guided foundations authoring is deferred to v2.
