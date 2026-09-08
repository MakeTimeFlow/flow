# Plan my day (Aligned Action)

Join the week's intention to today's reality, then propose a realistic, aligned day. Tool usage and gotchas are in `mcp-tools.md`; unfilled-story detection and posture are in `aligned-action.md`.

**If it's the start of the day, offer BeginWell first.** The morning ritual sets up the day more fully than a task list does: `create_task` titled `"Do begin 10m"` and `start_timer` on it opens it in the app (`mcp-tools.md`). Plan here instead when they'd rather, or afterwards.

1. **Read intention.** `list_stories` (no args) → the current stack. `read_story` on the short_term story (primary), plus medium/long for context, and `get_foundations` for the **ordered** values — that order is the tiebreak order in step 6. Apply detect-and-prompt: if the weekly story is unfilled (missing from the stack, or still reads as the starter template), **stop** and offer coaching (`success-story-coaching.md`) — or first-run migration (`aligned-action.md`) — before continuing. If **values** are empty, note it and carry on: the day is never gated on foundations, and the mirror-and-correct offer rides at the close (step 9).

2. **Ground time.** `get_temporal_context` → today, week boundaries, next event, working hours.

3. **Candidates.** `list_tasks` with `query: "@today"`; widen with `@next` / `priority:high` as needed to gather the candidate set.

4. **Capacity (don't eyeball it).** `assess_capacity` with `window: "today"` → the realistic focused-work ceiling (~4h cap). Take this number seriously.

5. **Fit check.** `check_fit` with the proposed `task_ids[]` and `window: "today"` → catch overcommit before proposing it.

6. **Coach to a realistic, aligned set — and name the value.** Choose the few tasks that serve the weekly story, fit inside capacity, and leave white space. Say *why* each earns the day, and when two candidates both fit and both serve the week, **the value breaks the tie and you name it**: "this one, because it serves Craftsmanship." Use the user's own values in their own order (step 1), never an invented one — if none of them picks between two tasks, say so plainly rather than reaching. See `aligned-action.md`.

7. **Draft → confirm → write.** Present the proposed set — tasks to create or refile, plus any time-blocks — and get a yes. Then write it: `create_task` with `start_at` + `expected_duration` to time-block a **new** task; `update_task` with `start_at` + `expected_duration` to schedule an **existing** task onto the calendar (most day-planning is this — scheduling tasks you already have); or `move_bucket` to pull an existing task into `@today` without a set time. Both time and duration are required for a real block — see `mcp-tools.md`. Never create, schedule, or move silently.

8. **Handoff — into the declaration, not just the timer.** Offer to start the first block now, and run it through `intentional-timer.md` rather than firing `start_timer` bare: what done looks like, why this now (the value you just named), the if-then guard for the derailment they predict, and the environment. A plan that ends in a declaration turns into doing; one that ends in a list usually doesn't. Note that the weekly WRAP closes the loop at week's end.

9. **At the close only — one offer, if it's earned.** If values were empty in step 1, offer the mirror-and-correct once (`aligned-action.md`): you can propose what they appear to value from their own reflections and let them correct it, or hand them the picker at https://my.maketimeflow.com/values. One line, after the plan is done, and a no ends it for the session. Never open the day with this.

## What arrives on its own

Before proposing anything, `read_repeating_tasks`. Its `assignment` says whether today's repeating lines arrive automatically each morning (`automatic`) and whether the week's time blocks are already placed ahead (`assign_ahead` beyond `on_the_day`). If they are, they are already in the list and on the calendar: plan *around* them, and never draft a task that duplicates a line in `todays_lines`. If assignment is manual, the lines wait for the user to press Assign in BeginWell — say so rather than assuming they exist.

## The depleted day — when none of it appeals

**Trigger:** *"I don't want any of this today"*, *"I've got nothing"*, *"none of this appeals."* Distinct from *"I can't start on this one thing"* — that one is the guard in `intentional-timer.md`, not a selection problem. Here the task set is wrong for the state the person is actually in.

**Lead with the diagnosis, because it is the intervention:**

> None of today's five touch how you actually work best. You're not unmotivated — you're mis-assigned.

That sentence is doing real work. It is testable, it makes no claim about who they are, and it points at a fix they can act on in the next ten minutes. "Try to push through" does none of those.

**Read three things — and one thing not to.** `get_foundations` for strengths in their own words; `list_reflections` for what they wrote on the days that went well, and what recurs; what actually got completed and where tracked time went. **Do not reach for a mood or energy rating.** Those columns exist and are effectively empty, and a trend narrated from a handful of stray numbers is invention dressed as data.

**Re-select; don't re-motivate.** `list_tasks` with `@next`, then `check_fit`. Offer two or three that clear all three bars:

1. They **fit how this person works** — the shape of the task, not the shape of the person.
2. They **land inside today's real window** — `assess_capacity`, and a depleted day may honestly warrant less than the usual ceiling. Take their word for the state; it is not measurable and does not need to be.
3. **The week or the quarter needs them anyway.** A task that fits but serves nothing is a pleasant afternoon and a worse week.

**The caution that keeps this honest.** Never make a trait claim — *"you're a deep-work person"* is not supported by the evidence and is not ours to say. The defensible version needs no theory at all: **work that fits how you operate is easier to begin when you're depleted.** That is a scheduling fact. Frame every suggestion as being about the task, never about the person.

If strengths are empty, don't demand them — route on what the reflections and the completion history actually show, and let the mirror-and-correct offer ride at the close as usual.

Then close the same way any day closes: into the declaration in `intentional-timer.md`. A depleted day needs the guard more than a normal one, not less — a gentler list with no pre-commitment is just a nicer way to not start.
