# Weekly WRAP — account, gap, homes, direction

Hold the week's reality against its intention, close what's dangling, then write next week. Tool usage and gotchas are in `mcp-tools.md`; the posture is in `aligned-action.md`.

**The feeling this is for:** *"Intense week, but good. Still lots to do, and I used my time well. I know where I'm going."* That is a **reconciliation** feeling — an honest account that comes out favourable — not a planning one.

**So the order is the intervention.** Opening on what's missing produces a weekly guilt artifact, and a guilt artifact with no adjacent lever is churn people stop showing up for. Account first, gap second — **same data, same honesty, opposite payload**. Do not reorder these steps to "get to the important part."

1. **Ground time.** `get_temporal_context` → week boundaries.

2. **The account — always open here.** What actually got delivered, and where the time actually went.

   - `time_spent_summary` (`period: "this_week"`) → the real totals, grouped by task and by priority. **This is the figure an LLM botches by hand — trust the tool, never an estimate.**
   - `list_tasks` with `query: "completed:this_week"` → exactly the work **finished** inside the week, bounded at both ends and resolved in the user's own zone. It already means completed work, so it needs no status filter beside it. **Never reach for `@this_week` here** — that matches when work was scheduled or *due*, not when it was done, and silently reports a different week.
   - Read it back **concretely and by name**. Not "you completed 23 tasks" — the two or three that mattered, and where the hours actually landed.

   **Specific beats generous.** An inflated account is worse than none, because the person was there and knows. If the week was genuinely thin, the account is short and honest, and that is still the right opening move.

3. **The gap — second, and it arrives with a lever.** `read_story` on the current short_term story and hold the totals against what the week said it would be.

   - Be honest about what this is: tasks carry **no stored link** to horizons or values, so this is a *judgment* comparison grounded on deterministic time totals — not a computed alignment rollup. Say so rather than implying a calculation.
   - **Name whether it's a one-off or structural.** "Tuesday went to the incident" is a one-off and needs nothing but naming. "Deep work loses to meetings every single week" is structural — and structural gaps need a change to the *shape* of the week, not more resolve. Which one it is, and why you think so, is the lesson; carry it into step 5.
   - The gap is about the week, never a verdict on the person. The watcher's evaluation on the story is extra input, not the verdict either.

4. **The homes — everything still open gets one.** `stalled_tasks` with `bucket: "both"` → for each avoided / abandoned / deferred task, give it a real home: `complete_task`, `cancel_task`, `set_waiting_for`, `add_followup`, or `move_bucket`. When there's a big block of "real, but not now", park it as a named set — the homes table and the park are in `triage.md`, and the same rule applies here: draft the dispositions together, take one yes, then execute.

   This step is what earns *"still a lot to do, and that's fine."* Nothing dangling is what makes a long list feel survivable instead of threatening.

5. **The direction — next week carries the lesson.** Coach and **draft** next week's story in chat (see `success-story-coaching.md`), carrying forward what step 3 found — especially if it was structural, because that is a change to how the week is built, not a promise to try harder. On approval: `update_story` with `horizon: "short_term"`, `period: "next"` — the server keeps this week's story as history automatically (**no archiving step**), and the draft becomes the current story when its window arrives. Committing it live is the user's own gesture, later, in its own moment (`update_story_stage` on their explicit ask — e.g. Monday's BeginWell).

6. **Handoff.** Offer plan-my-day for the fresh week — or, if they're heading straight into work, take the first block through the declaration in `intentional-timer.md`.
