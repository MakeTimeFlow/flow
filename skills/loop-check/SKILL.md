---
name: loop-check
description: Find the loops that closed on paper but not in life — work marked done whose outcome never landed, plus waiting-fors that have gone quiet.
disable-model-invocation: true
---

# Loop-check

Run the loop-check playbook. Read these first, then follow the playbook's numbered steps in order:

1. `../flow/SKILL.md` (paths are relative to this skill's own directory) — the way, and the draft-confirm-write posture
2. `../flow/references/loop-check.md` — the playbook itself
3. `../flow/references/mcp-tools.md` — tool usage and the gotchas that bite

Four things that go wrong most often, so hold them in mind from the start:

- **`followup:none` returns candidates, not verdicts.** Most completed tasks are simply done, and the chain only records loops closed *through* the system — so absence of a follow-up is absence of evidence, not proof of a drop.
- **Never hand back the raw list.** On most accounts nearly every completed task has no follow-up recorded. Presenting that as "loops you dropped" is false, it reads as an accusation, and it guarantees nobody runs this twice.
- **The judgment is the work.** Keep only the ones whose outcome lives outside the task — sent, decided, handed off, "v1". Expect one or two real things and let the rest pass without comment.
- **Waiting-for has no since-date.** It is a tag in a title, not a field. Ask how long it has been; never imply you can tell.

This is the opposite end from the WRAP's stalled pass: stalled means never finished, a dropped loop means finished with nothing carrying the outcome.

If the MakeTimeFlow tools aren't available, run `/flow:setup` first.
