---
name: plan-my-day
description: Plan today the MakeTimeFlow way — read the week's success story, ground capacity honestly, and propose a realistic aligned day.
disable-model-invocation: true
---

# Plan my day

Run the plan-my-day playbook. Read these first, then follow the playbook's numbered steps in order:

1. `../flow/SKILL.md` (paths are relative to this skill's own directory) — the way, and the draft-confirm-write posture
2. `../flow/references/plan-my-day.md` — the playbook itself
3. `../flow/references/mcp-tools.md` — tool usage and the gotchas that bite

Two things that go wrong most often, so hold them in mind from the start:

- **Never estimate focused-work hours by hand.** `assess_capacity` and `check_fit` exist because this is the calculation an LLM gets wrong. Honor the ~4h ceiling and leave white space.
- **A time-block needs both `start_at` and `expected_duration`.** A start time alone will not render on the calendar.

If the MakeTimeFlow tools aren't available, run `/flow:setup` first.
