# Plan my day (Aligned Action)

Join the week's intention to today's reality, then propose a realistic, aligned day. Tool usage and gotchas are in `mcp-tools.md`; unfilled-story detection and posture are in `aligned-action.md`.

1. **Read intention.** `list_stories` (no args) → the current stack. `read_story` on the short_term story (primary), plus medium/long for context, and `get_foundations` for the values the week serves. Apply detect-and-prompt: if the weekly story is unfilled (missing from the stack, or still reads as the starter template), **stop** and offer coaching (`success-story-coaching.md`) — or first-run migration (`aligned-action.md`) — before continuing.

2. **Ground time.** `get_temporal_context` → today, week boundaries, next event, working hours.

3. **Candidates.** `list_tasks` with `query: "@today"`; widen with `@next` / `priority:high` as needed to gather the candidate set.

4. **Capacity (don't eyeball it).** `assess_capacity` with `window: "today"` → the realistic focused-work ceiling (~4h cap). Take this number seriously.

5. **Fit check.** `check_fit` with the proposed `task_ids[]` and `window: "today"` → catch overcommit before proposing it.

6. **Coach to a realistic, aligned set.** Choose the few tasks that serve the weekly story and its values, fit inside capacity, and leave white space. Name *why* each earns the day.

7. **Draft → confirm → write.** Present the proposed set — tasks to create or refile, plus any time-blocks — and get a yes. Then write it: `create_task` with `start_at` + `expected_duration` to time-block a **new** task; `update_task` with `start_at` + `expected_duration` to schedule an **existing** task onto the calendar (most day-planning is this — scheduling tasks you already have); or `move_bucket` to pull an existing task into `@today` without a set time. Both time and duration are required for a real block — see `mcp-tools.md`. Never create, schedule, or move silently.

8. **Handoff.** Offer to start the first block now — `start_timer` (`kind: "focus"`, the task's `task_id`, optionally `duration_minutes`) begins the intentional timer so the plan turns into doing. Note that the weekly WRAP closes the loop at week's end.
