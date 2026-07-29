# Weekly WRAP + close the loops

Hold the week's reality against its intention, close what's dangling, then write next week. Tool usage and gotchas are in `mcp-tools.md`; the posture is in `aligned-action.md`.

1. **Ground time.** `get_temporal_context` → week boundaries.

2. **Where time actually went.** `time_spent_summary` with `period: "this_week"` → the accurate totals. This is the figure an LLM botches by hand; trust the tool, not an estimate.

3. **Hold totals against intention.** `read_story` on the current short_term story and surface the **gap** between where time actually went and where the week's story intended it to go. Be honest about what this is: MakeTimeFlow tasks have **no stored link to horizons or values**, so this is a *judgment* comparison grounded on deterministic time totals — not a computed alignment rollup. Name the gap plainly; that gap is the week's lesson. The watcher's evaluation on the story (headline, section coverage) is extra input, not the verdict.

4. **Close the loops.** `stalled_tasks` with `bucket: "both"` → for each avoided / abandoned / deferred task, resolve it so nothing silently drops, via `complete_task`, `cancel_task`, `set_waiting_for`, `add_followup`, or `move_bucket`. Each resolution is a write: draft → confirm → execute.

5. **Write next week.** Coach and **draft** next week's story in chat (see `success-story-coaching.md`), carrying forward the lesson from the gap. On approval: `update_story` with `horizon: "short_term"`, `period: "next"` — the server keeps this week's story as history automatically (**no archiving step**), and the draft becomes the current story when its window arrives. Committing it live is the user's gesture, later, in its own moment (`update_story_stage` on their explicit ask — e.g. Monday's BeginWell).

6. **Handoff.** Offer to run plan-my-day for the fresh week.
