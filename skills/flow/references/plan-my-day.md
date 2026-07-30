# Plan my day (Aligned Action)

Join the week's intention to today's reality, then propose a realistic, aligned day. Tool usage and gotchas are in `mcp-tools.md`; unfilled-story detection and posture are in `aligned-action.md`.

1. **Read intention.** `list_stories` (no args) → the current stack. `read_story` on the short_term story (primary), plus medium/long for context, and `get_foundations` for the **ordered** values — that order is the tiebreak order in step 6. Apply detect-and-prompt: if the weekly story is unfilled (missing from the stack, or still reads as the starter template), **stop** and offer coaching (`success-story-coaching.md`) — or first-run migration (`aligned-action.md`) — before continuing. If **values** are empty, note it and carry on: the day is never gated on foundations, and the mirror-and-correct offer rides at the close (step 9).

2. **Ground time.** `get_temporal_context` → today, week boundaries, next event, working hours.

3. **Candidates.** `list_tasks` with `query: "@today"`; widen with `@next` / `priority:high` as needed to gather the candidate set.

4. **Capacity (don't eyeball it).** `assess_capacity` with `window: "today"` → the realistic focused-work ceiling (~4h cap). Take this number seriously.

5. **Fit check.** `check_fit` with the proposed `task_ids[]` and `window: "today"` → catch overcommit before proposing it.

6. **Coach to a realistic, aligned set — and name the value.** Choose the few tasks that serve the weekly story, fit inside capacity, and leave white space. Say *why* each earns the day, and when two candidates both fit and both serve the week, **the value breaks the tie and you name it**: "this one, because it serves Craftsmanship." Use the user's own values in their own order (step 1), never an invented one — if none of them picks between two tasks, say so plainly rather than reaching. See `aligned-action.md`.

7. **Draft → confirm → write.** Present the proposed set — tasks to create or refile, plus any time-blocks — and get a yes. Then write it: `create_task` with `start_at` + `expected_duration` to time-block a **new** task; `update_task` with `start_at` + `expected_duration` to schedule an **existing** task onto the calendar (most day-planning is this — scheduling tasks you already have); or `move_bucket` to pull an existing task into `@today` without a set time. Both time and duration are required for a real block — see `mcp-tools.md`. Never create, schedule, or move silently.

8. **Handoff.** Offer to start the first block now — `start_timer` (`kind: "focus"`, the task's `task_id`, optionally `duration_minutes`) begins the intentional timer so the plan turns into doing. Note that the weekly WRAP closes the loop at week's end.

9. **At the close only — one offer, if it's earned.** If values were empty in step 1, offer the mirror-and-correct once (`aligned-action.md`): you can propose what they appear to value from their own reflections and let them correct it, or hand them the picker at https://my.maketimeflow.com/values. One line, after the plan is done, and a no ends it for the session. Never open the day with this.
