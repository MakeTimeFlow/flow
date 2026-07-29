---
name: setup
description: Check the MakeTimeFlow connection and whether the Aligned Action horizons are ready to plan from. Run this first after installing the plugin.
disable-model-invocation: true
---

# Setup — is flow ready to run?

Check the two things that must be true before `/flow:plan-my-day` or `/flow:wrap` can do anything useful: the MCP server is connected, and the horizons have something in them. Report both plainly, then offer the one next step that unblocks the user.

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

Foundations are read-if-present. Name what's empty, but never gate the day on them.

## Posture

Everything above is a read, so run it without asking. The moment setup would *write* anything — a story, a value, a migration — draft it, get a yes, then act. Full posture in `../flow/SKILL.md`.
