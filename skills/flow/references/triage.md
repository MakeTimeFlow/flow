# Triage — everything gets a home

The move for *"I'm drowning."* Every other tool answers overwhelm by helping you **pick**. This one disposes of the ninety percent you are **not** doing, by giving each of those a named home — so the pile stops occupying you.

**Why it works, and it is worth saying out loud:** an unfinished commitment keeps intruding on unrelated work until it has a *specific plan* — and the plan alone removes the interference, without the task being done (Masicampo & Baumeister). The relief comes from the disposition, not from the doing. That is why the goal is **nothing left unhomed**, not "a shorter list."

**It works cold.** Twelve tasks, no timers, no story, no foundations — still good. Never gate this door on a story or a value; if they exist, use them at step 6, and if they don't, triage anyway.

Tool usage and gotchas are in `mcp-tools.md`; the posture is in `aligned-action.md`.

## Two kinds of relief, and they are not the same

Hold this distinction — conflating them is why "later" piles rot:

- **Cancelling** is *"I've decided not to do this."* The relief is **finality**. It's a soft delete: recoverable, but the decision is made.
- **Parking** is *"I've decided not to decide now."* The relief is that the deciding is **scheduled** rather than avoided.

Someone who won't cancel something is usually not being indecisive — they are refusing a false binary between *do it* and *kill it*. Offer the third option before pushing for the second.

1. **Ground time.** `get_temporal_context` → today, the week, what's already committed. You need it to judge "when would this be true again."

2. **Gather the whole pile, not today's slice.** `list_tasks` across `@inbox`, `@today`, and `@next` at minimum; add `@later` when the user says "everything." **A triage that only looks at today reproduces the overwhelm it was called to fix** — the relief comes from seeing the whole thing at once and disposing of it.

3. **Sort fast, out loud, one home each.** Speed is the feature. Propose a home for every task in one pass and let the user correct you; do not open a discussion per item, and do not stop to be sure. Every task gets **exactly one** home:

   | Home | Means | Tool |
   |---|---|---|
   | **Today** | Genuinely doing it today — a small number, checked in step 5 | `move_bucket` → `today` |
   | **Next** | Real and soon, not today | `move_bucket` → `next` |
   | **Later** | Real, but not now — the *"seen it, keep it"* shelf | `move_bucket` → `later` |
   | **Waiting on someone** | It isn't yours to move right now | `set_waiting_for` (name the person in `waiting_on`) |
   | **Not happening** | Decided against — the honest one, and the most valuable | `cancel_task` |
   | **Not a task at all** | Reference, a link, an idea — something to keep, not do | `update_task` → `task_type: "information"` |

   `later` is a real shelf, not a graveyard: moving something back to `today` or `next` is the un-park, and the system treats that gesture as *"I will act on this."*

4. **When the later pile is big, park it as a set.** Under about ten items, a bare `later` is right and a container is ceremony. Past that, `later` becomes its own overwhelm the moment it's opened — so give the block **a name and a return date**:

   - `create_task` with `task_type: "folder"`, `bucket: "later"`, titled in the user's own words — *"Not doing now"*, *"Not priorities this quarter"*.
   - `update_task` each parked task with `parent_task_id` (the folder) **and** `bucket: "later"` in the same call.
   - **Reuse before creating.** Look for a park folder that already exists; a new one per session becomes nine folders that all mean "not now."

   The name is the point, not the hiding — `later` already hides. *"It's in later"* is a location; *"not doing now, because I'm shipping this quarter"* is the specific plan that produces the relief. **Say when it gets re-opened** (the WRAP is the natural place) — a park with no return is just a cancel that nobody had to admit to.

5. **Recognize what things actually are.** Some of the pile isn't a normal task, and naming the type *is* the disposal:

   - **A project** — an outcome bigger than one sitting. `task_type: "project"`. **Do not make the user decompose it into a next action first**: projects here are actionable and time-blockable directly. Recognizing it is enough.
   - **Information** — a link, a reference, an idea. `task_type: "information"`. Ideas nag because they are miscategorized as obligations; re-typing removes the obligation without losing the idea, and the system then keeps it out of counts and planning surfaces on its own.
   - **A folder** — pure organization, never work. `task_type: "folder"`.

   A task the user cannot describe an outcome for is often a **decision** they haven't made. Name that; the home is usually the park or the cancel pile.

6. **Capacity-check what survived to today.** `assess_capacity` (`window: "today"`), then `check_fit` on the today set. **Triage that leaves eleven things in today has failed** — it just moved the pile. Push back with the number, not with an opinion.

7. **Say what it cost, using their values.** For the today set, name why each earns the day — and when two both fit, **the value breaks the tie, by name** (`get_foundations`, see `aligned-action.md`). For the cancel pile, say plainly what is being let go and move on. **Do not moralize about it**; deciding not to do something is the work, not a failure at it.

8. **Draft the whole table, take one yes, then execute.** Present every disposition together and get a single approval for the batch — then run the writes. **Never write during the sort.** Item-by-item confirmation is unreviewable at this volume and turns a five-minute relief into an interrogation. If the user changes some rows, re-present only what changed.

9. **Close by starting.** Take the first task straight into a declaration — `intentional-timer.md` — so the session ends in motion rather than in a tidy list. Triage that ends with a clean list and no start has done half the job, and the person who was drowning an hour ago is exactly the one who needs the guard, not just the timer.

## Gotchas that bite here specifically

- **`add_followup` completes the original.** It is for *"that's done, and the next action is X"* — never for parking something. Reaching for it to defer a task silently marks the thing complete.
- **`set_waiting_for` moves the task to `next`** and clears a past scheduled time, and it is a **no-op on a task already waiting** — the `waiting_on` note won't change. To correct one, edit the title with `update_task`.
- **Waiting-for is a tag in the title, not a person field with a date.** You cannot age it against how long that person usually takes. Don't imply otherwise.
- **`cancel_task` cancels the task's sub-tasks too**, and stays recoverable. Say so when a parent goes in the cancel pile — that is the one place a fast sort can surprise someone.
- **Moving an information node to `today` or `next` re-types it to a normal task.** That is correct — the gesture means "I will act on this" — but it means you cannot use those buckets to shelve something and keep it as reference. `later` is deliberately exempt, which is why it is the shelf.
- **Re-typing is refused on meeting invitations and on calendar-synced tasks**, and `set_waiting_for` refuses on read-only synced tasks too — `add_followup` is the intent-preserving alternative the tool itself suggests.
- **The `reference` bucket is a harsher hide than parking** — it drops a task out of the outliner entirely. It is not part of triage; use `later`, with a folder when the block is big.
- The buckets are exactly `inbox`, `today`, `next`, `later`, `reference`, `archived`. There is no "someday" — that's `later`.
