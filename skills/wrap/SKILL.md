---
name: wrap
description: Run the weekly WRAP the MakeTimeFlow way — account for what you actually delivered and where the time went, hold that against what the week meant to be, give everything still open a home, and write next week's success story.
disable-model-invocation: true
---

# Weekly WRAP

Run the weekly WRAP playbook. Read these first, then follow the playbook's numbered steps in order:

1. `../flow/SKILL.md` (paths are relative to this skill's own directory) — the way, and the draft-confirm-write posture
2. `../flow/references/weekly-wrap.md` — the playbook itself
3. `../flow/references/mcp-tools.md` — tool usage and the gotchas that bite
4. `../flow/references/success-story-coaching.md` — for step 5, writing next week

Four things that go wrong most often, so hold them in mind from the start:

- **Open on the account, not the gap.** The order — account, gap, homes, direction — *is* the intervention. Leading with what's missing turns the WRAP into a weekly guilt artifact, which is the single thing most likely to stop someone doing it again.
- **Get the totals from `time_spent_summary`, never by hand.** And when listing what got completed, filter on each task's own `completed_at` — the `@this_week` filter matches `start_at`/`deadline`, not when something was finished, so it reports the wrong week's work.
- **The gap is a judgment call, not a computed rollup.** Tasks carry no stored link to horizons or values — say so plainly rather than implying a calculation. Then name whether it's a one-off or structural, because only one of those calls for changing the shape of the week.
- **Writing next week's story does not commit it.** `update_story` with `period: "next"` writes the draft; `update_story_stage` only ever runs on the user's explicit ask.

If the MakeTimeFlow tools aren't available, run `/flow:setup` first.
