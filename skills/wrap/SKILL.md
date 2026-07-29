---
name: wrap
description: Run the weekly WRAP the MakeTimeFlow way — hold where time actually went against where it was meant to go, close stalled loops, and write next week's success story.
disable-model-invocation: true
---

# Weekly WRAP

Run the weekly WRAP playbook. Read these first, then follow the playbook's numbered steps in order:

1. `../flow/SKILL.md` (paths are relative to this skill's own directory) — the way, and the draft-confirm-write posture
2. `../flow/references/weekly-wrap.md` — the playbook itself
3. `../flow/references/mcp-tools.md` — tool usage and the gotchas that bite
4. `../flow/references/success-story-coaching.md` — for step 5, writing next week

Three things that go wrong most often, so hold them in mind from the start:

- **Get the totals from `time_spent_summary`, never by hand.** The gap between those totals and the week's intention is the whole point of the WRAP.
- **The gap is a judgment call, not a computed rollup.** Tasks carry no stored link to horizons or values — say so plainly rather than implying a calculation.
- **Writing next week's story does not commit it.** `update_story` with `period: "next"` writes the draft; `update_story_stage` only ever runs on the user's explicit ask.

If the MakeTimeFlow tools aren't available, run `/flow:setup` first.
