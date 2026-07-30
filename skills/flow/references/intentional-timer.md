# The intentional timer — declare, guard, protect

The move for *"I can't make myself start"*, and the closing move of triage and plan-my-day.

**The product is the declaration; the timer is only its last step.** Starting a timer is not the point — the app has a button for that and it is faster than a conversation. The point is a commitment that **reprograms the next forty minutes**: pre-deciding what done looks like, why this now, and what you will do when the predictable derailment arrives, so none of it gets re-litigated in the moment. That pre-commitment is the single best-evidenced move in this whole skill — if-then intentions show a large, consistent effect across ~94 studies (Gollwitzer & Sheeran).

**Why this isn't Freedom or Forest.** Blockers guard the environment and know nothing about *why this task*. Focusmate adds a witness but no intention. None of them can say *"this is forty minutes on the thing your quarterly story needs, and it serves Craftsmanship."* That sentence is only possible on top of the foundations — which is why they are load-bearing (`aligned-action.md`).

Tool usage and gotchas are in `mcp-tools.md`.

1. **Check what's already running — first, always.** `list_active_timers`. **Starting a timer does not stop a running one**, and two live timers double-count into `time_spent_summary` — the one number the WRAP trusts. If something is running, either it *is* this block (carry on, don't start a second) or stop it with `stop_timer` before declaring. Never quietly stack.

2. **Pick the one thing, if it isn't already chosen.** Arriving from triage or plan-my-day, it is. Cold, `list_tasks` with `@today` and choose — and when two both fit, **the value breaks the tie, by name**.

3. **Take the declaration — four parts, in order.** Ask for them; don't compose them. The user's own words are what bind.

   1. **What done looks like.** The *outcome*, not the activity: "the migration plan is drafted and I've sent it to Harrison", not "work on the migration". If they can't say what done looks like, the block is the wrong size or the task is really a decision.
   2. **Why this, now.** Against a value or the week's story, named (`get_foundations`, `list_stories` if not already in hand). One sentence. This is the part nothing else in the category can do.
   3. **The rabbit-hole guard.** Ask *"what will pull you off this?"* — people know, and they answer instantly. Then get the response pre-committed, in **if-then** form: *"If I open the analytics dashboard to check one number, I write the number down and close the tab."* **Specificity is the mechanism.** "I'll try to stay focused" is not a guard and buys nothing; a named derailment with a named response is the whole effect.
   4. **The environment.** A short checklist they confirm out loud — phone out of reach, notifications off, tabs closed, door shut. Environment design beats willpower, and confirming it aloud is part of the commitment.

4. **Set the length honestly.** Pass `duration_minutes` when they've declared one. Left off, a focus timer takes the task's own estimate, or 25 minutes. Longer blocks are not more virtuous — a declared 25 that holds beats a 90 that dissolves.

5. **Start it.** `start_timer` with `kind: "focus"`, the `task_id`, and the duration. That links the timer to the task, **marks the task started**, and the desktop app picks it up on its own. Then get out of the way: reflect the declaration back in two lines and stop talking.

6. **The return — hold the guard, don't scold.** When they come back, or ask you to check on them: `list_active_timers` gives `state` (plenty / comfortable / soon / urgent / expired) and `overrun_minutes`. **An overrun is usually the rabbit hole having happened** — so name it against the guard *they* pre-committed to, as information rather than judgment: *"you're 20 over, and the guard was the analytics dashboard — did that happen?"* The answer is useful either way, and next block's guard gets better.

   Then close: `stop_timer` returns `actual_minutes`. Offer a real break (`kind: "break"`, no task, named with `label`) or the next declaration. If something worth keeping came out of the block — a realization, a reason it went badly — that is exactly what `create_reflection` is for, on their yes.

## Rules

- **Never start a timer without a declaration.** A timer with no intention is a stopwatch, and the user already has a faster button for that. If they want to just start, start — but then this door added nothing, and say so rather than dressing it up.
- **The guard must be specific and if-then.** A generic intention to focus is not the intervention.
- **One block, one thing.** A declaration covering three tasks is not a declaration.
- **Don't relitigate mid-block.** Once it's running, the conversation is over. That's the point.

## Gotchas

- **Starting a timer does not stop a running one** — the response carries `also_active` so you can see what you just stacked. Check first.
- **`label` is ignored when `task_id` is given.** The timer takes the task's own title, so the declaration will not appear in the app. Don't promise it will. `label` names an *ad-hoc* focus block (no task) or a break — and a focus timer with no `task_id` **requires** one.
- **`start_timer` marks the linked task `started`.** That is intended, but it's a write — it counts as the action being underway.
- **An identical start within ~15 seconds returns the existing timer**, not a second one. A repeated call is safe; it is not a way to restart.
- **`stop_timer` with no `timer_id` stops the only running timer** and errors — listing them — when several are running. It never guesses.
- **Breaks are real, not the absence of a timer.** `kind: "break"` takes no `task_id` and defaults to 5 minutes.
