---
name: setup
description: Check the MakeTimeFlow connection and whether the Aligned Action horizons are ready to plan from. Run this first after installing the plugin.
disable-model-invocation: true
---

# Setup — is flow ready to run?

Check the two things that must be true before `/flow:plan-my-day` or `/flow:wrap` can do anything useful — the MCP server is connected, and the horizons have something in them — then look at the foundations the daily loop reasons with. Report plainly, then offer the **one** next step that unblocks the user. Only the first two can block; the third is an offer.

File paths below are relative to this skill's own directory.

## 1. Is the MakeTimeFlow MCP connected?

Call `get_temporal_context` (no arguments — it is the cheapest read).

- **It returns today's date and working hours** → connected. Continue to step 2.
- **The tool does not exist** → the server is not connected. Tell the user to run `/mcp` and connect **maketimeflow**, which opens a browser to sign in with their MakeTimeFlow account. In Cowork, the connector is approved from the plugin's own settings. Stop here — nothing else works until this does.
- **It errors with an auth or scope problem** → the connection exists but the grant is incomplete. Have them reconnect via `/mcp` and approve both read **and** write; `mcp:write` is what lets flow create tasks and write stories.

## 2. Are the horizons filled?

Call `list_stories` (no arguments) for the current stack, and `get_foundations` for values, strengths, and relationships.

Apply the unfilled test in `../flow/references/aligned-action.md` — a horizon is unfilled if it is missing from the stack **or** its content still reads as the untouched starter template. Then report:

- **Weekly (short_term) story filled** → flow is ready. Offer `/flow:plan-my-day`.
- **Weekly story unfilled** → this is the one that matters most; plan-my-day cannot align to a story that isn't written. Offer to write it now via `../flow/references/success-story-coaching.md`.
- **Everything unfilled and a legacy local `flow/` workspace exists** → offer the first-run migration in `aligned-action.md` instead of writing from scratch.
- **Medium/long unfilled but weekly filled** → say so, don't block. The week can be planned; offer the quarterly and five-year later.

## 3. Are the foundations there to reason with?

Values are the tiebreak the daily loop uses, so an empty values list is worth naming — **but never as a gate, and never as a task list handed to the user.**

- **Values present** → say how many, and that the day's choices will name them.
- **Values empty** → offer the **mirror-and-correct** move in `../flow/references/aligned-action.md`: you can read their recent reflections and completed work and propose two or three values for them to correct, or they can pick from the list at **https://my.maketimeflow.com/values** — `/strengths` and `/relationships` likewise. Offer once. A no ends it.
- **Strengths / relationships empty** → mention in passing at most. They matter later (routing under depletion, relationship noticing), not on day one.

Foundations also carry an age: `get_foundations` returns `values_updated_at` and friends. Years-old values are worth re-meeting, not rewriting.

## Posture

Everything above is a read, so run it without asking. The moment setup would *write* anything — a story, a value, a migration — draft it, get a yes, then act. Full posture in `../flow/SKILL.md`.
