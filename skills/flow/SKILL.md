---
name: flow
description: Plan the day, get out from under the pile, and run the weekly WRAP the MakeTimeFlow way — reading and writing the Aligned Action horizons (success stories + foundations) live in MakeTimeFlow, joined to tasks, timers, and time-calculation. Use when the user says plan my day, what should I work on, I'm drowning, there's too much, help me triage, weekly review, wrap, write/update my success story, set my goals, or "the MakeTimeFlow way."
---

# flow — Aligned Action, live in MakeTimeFlow

`flow` runs the MakeTimeFlow daily loop. **Intention and execution both live in MakeTimeFlow**, reached through the MCP: the three horizon success stories (long / medium / short) and the foundations (values, strengths, relationships) are the personal ledger, and tasks, timers, time-calculation, capacity, and stalled detection are the execution layer. This skill is the choreography: it reads the current story stack and foundations, drives the day's plan, and runs the **weekly WRAP**, so daily action stays tied to the week's success story and the values it serves.

## The way (in brief)

- Choose daily action by **alignment to the weekly success story** (the short_term story in the current stack) — not by what's loudest.
- **The foundations decide, and you say so.** When two candidates both fit, the **value breaks the tie and gets named out loud**. Values, strengths, and the horizon stack are the reasoning substrate here, not a preamble — `references/aligned-action.md` says how each one is load-bearing.
- Respect a **realistic focused-work ceiling** (~4h/day). Plan to it and **leave white space**; an overfull day is a planning failure.
- **Everything gets a home.** Overwhelm is answered by *disposal*, not by picking harder: the ninety percent you aren't doing each get a named home, which is what actually stops the pile occupying you.
- **Close every loop.** A task isn't done until its outcome is handled — chain followups and mark waiting-for so nothing silently drops.
- Weekly, **hold where time actually went against where you intended it to go** — the gap is the lesson.
- **Maintain the horizons; don't just set them.** A story nobody revisits guides nothing, and staleness is detectable — re-meet it, don't rewrite it.
- Full method lives at **https://help.maketimeflow.com** — this skill is the operational summary, not a replacement. If a local methodology corpus is present on this machine, prefer it.

## Interaction posture

Reads are free. **Never create or modify anything silently — draft it, get a yes, then act.** This holds for every MakeTimeFlow write: tasks, time-blocks, and every ledger write (stories, values, strengths, relationships, journal reflections), all of which also pass the MCP `mcp:write` consent. Two ledger-specific rules: **stories are whole-body writes** (read first, rewrite the full document, send it all back), and **committing a story is the user's explicit gesture** — never call `update_story_stage` as a side effect of writing.

**Foundations are earned, never demanded.** The skill does not run an authoring wizard and never gates the day on an empty foundation. When values are missing, the move is to **mirror and correct** — propose what the user already appears to value from their own reflections and behaviour, tentatively, and let them fix it — offered once, declinable, with a link out to the picker for anyone who'd rather not do it in chat. Their reflections are private writing: reflect them back to the user only, and check `authored_by` before quoting so you never hand an assistant's earlier words back as their own.

## Entry points

| When the user says… | Use | Typed door |
|---------------------|-----|------------|
| "I'm drowning" / "too much" / "I can't start" | `references/triage.md` | `/flow:triage` |
| "plan my day" / "what should I work on" | `references/plan-my-day.md` | `/flow:plan-my-day` |
| "weekly review" / "wrap" | `references/weekly-wrap.md` | `/flow:wrap` |
| "write/update my success story" / "set my goals" | `references/success-story-coaching.md` | — |
| first run / stories are empty or template | `references/aligned-action.md` (framework · unfilled detection · staleness · mirror-and-correct cold start · legacy-workspace migration) | `/flow:setup` |
| "which MCP tool / how" | `references/mcp-tools.md` | — |

The typed doors are thin routers into these same files, for users who would rather type a command than describe what they want. Routing is identical either way.

## Legacy workspace

Earlier versions of this skill kept intention in a local `flow/` directory. That workspace is now a **migration source only**: if it exists with filled horizons/foundations while the MakeTimeFlow ledger is still unfilled, offer to migrate its content up (see `references/aligned-action.md`). If MakeTimeFlow is unreachable, say so and stop — don't fall back to planning from stale local files without flagging it.
