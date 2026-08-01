# Shutdown — close the day

The day has a start and a middle in this skill; this is the end of it.

**MakeTimeFlow has its own Shutdown ritual, and it is the better one.** It walks the reflection, your waiting-fors, the messages that need a last look, tomorrow's blocks, and an actual stop — several of which this conversation cannot reach at all. **Offer it first**, every time:

> Want to run your Shutdown in MakeTimeFlow? It's the fuller version — I can start it for you. How long do you want to give it?

**You can actually launch it**, not just recommend it: take a length (fifteen minutes is realistic; people underestimate), `create_task` titled `"Do shutdown 15m"`, then `start_timer` on it with no duration. The timer runs and the ritual opens in the app. See "Launching a ritual in the app" in `mcp-tools.md`.

That is the better outcome most nights, and offering it costs one question.

If they'd rather close the day here — or they're not at the app — do it here, and be straight about what that is. **This does not complete their Shutdown ritual.** What it writes is a **journal reflection alongside** their own, visible where they already look. Never say the ritual is done.

**What a shutdown is actually for.** Not an empty inbox and not an empty task list — neither is achievable and chasing them is why people abandon the ritual. It is for **ending the day with nothing unplanned that still has a hook in you**, and with tomorrow's first move already decided and set up. Those two things are what let someone genuinely stop.

**Keep it short.** Five minutes, not twenty. A closing ritual that feels like more work does not happen at 6pm when someone is tired, and one that does not happen is worth nothing.

Tool usage and gotchas are in `mcp-tools.md`; the posture is in `aligned-action.md`.

1. **Stop the clock, quietly.** `list_active_timers`, and `stop_timer` anything still running. Do it without making it the conversation — a timer left going overnight quietly corrupts where tomorrow says the time went, and the weekly account is built on those numbers.

2. **Ask them first — before you look anything up.** One open question, and nothing else:

   > How was today?

   **This has to come before the record, and the reason is the whole design.** Read their completed tasks back to them first and their reflection becomes a commentary on that list — you get the day as the system already sees it, which is the half you didn't need. Ask cold and you get the *gestalt*: what they were actually in the middle of, the thing that went well, the thing they're worried about. That is the part no query returns.

   **Make it cost nothing.** One word is a complete answer. "Brutal" is data. Don't probe, don't ask a second question, and don't reflect it back yet — just receive it.

   **If they've got nothing, don't push.** At the end of a hard day, producing a reflection from a blank page is real work and this is exactly when someone has least to give. Move to step 3, and let the record become the prompt: *"you finished the migration and two other things — does that match how it felt?"* Getting it second is much better than not getting it.

3. **Now the record — as an addition, not a correction.** `list_tasks` with `query: "completed:today"`. Read two or three back **by name**.

   Watch for the gap between what they just told you and what the day actually holds. People end days certain they achieved nothing, and the list very often disagrees — **and that only lands once they've said it first.** Name it gently and without triumph: *"for what it's worth, you closed four things, including the one you'd been avoiding."*

4. **What would still be on your mind at nine tonight?** — this is the real work of shutting down.

   > Anything you'd find yourself checking later, or thinking about when you're trying to switch off?

   Not "what's unfinished" — most unfinished things are fine. Ask for the ones with a **hook in them**: the message they half-expect, the thing they promised someone, the worry that isn't even a task. Whatever they'd otherwise open the laptop at nine to check.

   **Each one gets a plan, and the plan is the point — not the doing.** An open commitment keeps intruding until it has a specific one, and then it stops, whether or not it's done. That is the whole reason a shutdown works.

   Usually that plan is time: `update_task` with a `start_at` and `expected_duration`. **It does not have to be tomorrow.** Thursday is fine. Saturday morning is fine for something personal — a non-work worry blocked into the weekend where it belongs is a real answer, not a dodge. Sometimes the plan is `set_waiting_for` because it's genuinely someone else's move, or a decision to let it go said out loud.

   > **Shutting down is not inbox zero.** Ending at zero is neither the goal nor usually possible. Ending with *nothing unplanned that has a hook in it* is the goal, and it is reachable most nights in a couple of minutes.

   If the whole list is loud rather than a few specific things, that's a triage, not a shutdown — offer `triage.md` tomorrow rather than starting one now while they're tired.

5. **Tomorrow's first move — and the runway for it.** The first block of the morning is usually the most valuable hour anyone gets, and it is routinely spent deciding what to do with it.

   Two parts, and the second is the one people skip:

   - **Name the one thing they'll start with**, and schedule it — `update_task` with `start_at` and `expected_duration`. Decided tonight, not negotiated at 9am.
   - **Ask what they need to have ready.** The document open, the file downloaded, the notes found, the thing physically on the desk — *and ideally nothing else on it.* Two minutes now removes the ten-minute warm-up that is where a good morning usually leaks away.

   Same principle as the focus declaration in `intentional-timer.md`: environment design beats willpower, and it is cheapest to do the night before.

   > **If they work evenings:** the shutdown still applies, and it matters more. The rule that makes it possible is to do **only what was time-blocked** for the evening — an evening that stays open never closes, so the day never ends. Offer this only if evening work comes up; it's an advanced move, not a default.

6. **Write it down — and write the whole arc, not just the ending.** If there's energy for one more question, ask *"anything worth remembering that isn't a task?"* — the evening that landed, the conversation that mattered, the thing that drained them is **the one input the system can never derive**. One follow-up at most; if they're done, they're done.

   The entry has **three parts**, in this order, because the shape is what makes it useful later:

   1. **How the day felt when asked** — their unprompted words from step 2, before they saw anything.
   2. **What was actually there** — the work that got done, briefly.
   3. **Whether that changed anything** — did the record shift how the day reads to them, or not? *"Still feels scattered"* is as real an answer as *"actually, that's a better day than I thought."*

   **Write it in first person, as them.** They will read this in their own journal beside entries they wrote themselves, so it has to sound like their day, not a report about their day:

   > Felt scattered — mostly firefighting and nothing of my own. Looking back I closed four things, including the migration I'd been putting off. Still feels like the week is getting away from me though.

   That third part is the one people skip and the one worth having. A day where the record changed nothing is as informative as one where it changed everything — over weeks it shows whether someone's sense of their own days is drifting from what those days contain.

   Draft it back, get a yes, then `create_reflection`. **Their phrasing, not your tidier version**, and none of your own advice folded in.

7. **Then stop.** Say the day is closed and mean it. Do not offer more work, do not start a timer, do not raise the thing you noticed in step 4. The close is the close.

## Gotchas

- **Never write into the Shutdown ritual's own reflection.** That field holds one value — their writing, with no other copy. `create_reflection` appends to the journal instead, which is what an append-only stream is for.
- **Don't claim the ritual is complete.** It isn't. Theirs still shows as unfinished in the app, and telling them otherwise is the one thing that would make this door untrustworthy.
- **`completed:today` means finished today**, not scheduled or due today.
- **Timers first.** Every other step is reversible; an overnight timer silently distorts a number the WRAP treats as ground truth.
- **Don't coach here.** Something worth working on will still be worth working on tomorrow, when they have the capacity to hear it.
- **Never open with the data.** Steps 2 and 3 are in that order deliberately. It is the one ordering in this playbook that changes what gets captured rather than just how it feels, and reversing it is invisible — you still get a reflection, just a thinner one about the tasks you showed them.
