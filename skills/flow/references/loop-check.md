# Loop-check — done is not delivered

The move for *"have I dropped something?"*

A task marked complete whose **outcome never landed** is the quietest failure in any system. Nothing is overdue, nothing is stalled, nothing appears on a list — the work is finished and the result simply never arrived. You sent the proposal; nobody replied; the task says done. That is a closed task and an open loop.

**This is the opposite end from the WRAP's stalled pass.** Stalled means never finished. A dropped loop means finished, with nothing carrying the outcome. They need different questions, and this one has no other home.

Tool usage and gotchas are in `mcp-tools.md`; the posture is in `aligned-action.md`.

## Read this before you run it once

**A missing follow-up is not evidence of a dropped loop.** Most completed tasks are simply done and need nothing. And the follow-up chain only records loops closed *through* the system — someone who chased a reply by just chasing it leaves no trace at all, and their loop closed fine.

So `followup:none` returns **candidates, not verdicts**, and on most accounts it returns nearly everything, because recording follow-ups is a habit few people have yet. **Never present the raw list.** Thirty completed tasks handed back as "loops you dropped" is both false and an accusation, and it is the fastest way to make someone never run this again.

The door's job early on is as much to *build* the chain as to audit it. Expect to find one or two real things, say so plainly, and let the rest go by without comment.

1. **Ground time.** `get_temporal_context` → today and the week, so "since when" means something.

2. **Pull the candidates.** `list_tasks` with `query: "followup:none completed:last_month"` — completed work with nothing following it. Narrow to `last_week` when the user wants a quick pass, widen to `this_month`/`last_month` for a real audit. Ask for the window rather than assuming one.

3. **Judge before you speak — this is the actual work.** Read the candidates and keep only the ones whose outcome lives **outside the task**:

   - **Sent, asked, submitted, invoiced, applied** → someone owes a response.
   - **Decided, agreed, chose** → somebody now has to act on it.
   - **Handed off, delegated, introduced** → it is in another person's hands.
   - **"Draft", "v1", "first pass", "spike"** → the shape implies a next round.
   - **A person's name in the title** → often a thread, not a task.

   Everything else — the errand, the chore, the thing that was its own outcome — is finished. Say nothing about it.

4. **Check what's already waiting.** `list_tasks` with `query: "@waiting_for"` → loops that are open *and* known. These may simply have gone quiet. **There is no since-date** — waiting-for is a tag in the title, not a field — so ask how long it has been rather than implying you can tell.

5. **Show a chain that worked, when there is one.** If the user asks how something got handled, `followup:<task_id>` reads that task's chain — including a follow-up that has itself been completed, which nothing else can surface. The point of this door is not only to find failures, and a loop that closed properly is worth seeing.

6. **Close them together — draft, one yes, then write.** For each real one:

   - `add_followup` on the original → creates the next action and links the chain. Safe on a task already completed; its original completion date is preserved.
   - `set_waiting_for` when it is genuinely someone else's move, naming the person in `waiting_on`.
   - Or **let it go explicitly** — "this one resolved itself, nothing needed" is a real answer, and saying it out loud is what stops it being re-raised next month.

   Present the whole set and take a single approval, as in `triage.md`. Never write during the sort.

7. **Handoff.** If something needs doing now, take it into the declaration in `intentional-timer.md`. Otherwise note that next month's pass will be shorter, because the chain is now recording.

## Gotchas

- **`followup:none` is a candidate filter, not a verdict.** See above; this is the one that matters.
- **`add_followup` completes the original** — which is fine here, since these are already completed, and `completed_at` is left alone so closing an old loop does not move it into this week's numbers.
- **Waiting-for carries no since-date and no person field** — it is a title tag. Age it by asking, never by asserting.
- **`completed:<period>` means finished in that window**, unlike `@this_week`, which matches when work was scheduled or due.
- **A chain records only what went through the system.** Absence of a follow-up is absence of evidence.
