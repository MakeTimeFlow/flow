---
name: focus
description: Start a focus block the MakeTimeFlow way — declare what done looks like, why it matters now, and what you'll do when you get pulled off, then run the timer against that declaration.
disable-model-invocation: true
---

# Focus

Run the intentional-timer playbook. Read these first, then follow the playbook's numbered steps in order:

1. `../flow/SKILL.md` (paths are relative to this skill's own directory) — the way, and the draft-confirm-write posture
2. `../flow/references/intentional-timer.md` — the playbook itself
3. `../flow/references/mcp-tools.md` — tool usage and the gotchas that bite

Four things that go wrong most often, so hold them in mind from the start:

- **The declaration is the product; the timer is its last step.** Starting a timer with no intention is a stopwatch, and the user has a faster button for that.
- **Check `list_active_timers` before starting.** Starting a timer does **not** stop a running one, and two live timers double-count into the totals the weekly WRAP trusts.
- **The rabbit-hole guard has to be specific and if-then.** "I'll try to focus" is not a guard. "If I open the dashboard to check one number, I write it down and close the tab" is.
- **Ask for the declaration; don't compose it.** The user's own words are what bind. Then reflect it back in two lines and get out of the way.

Coming back, or checking in mid-block? `list_active_timers` carries `overrun_minutes` and a state — an overrun is usually the rabbit hole having happened, so hold it against the guard they set, as information rather than judgment.

If the MakeTimeFlow tools aren't available, run `/flow:setup` first.
