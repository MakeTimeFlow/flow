# Aligned Action — the framework, in this skill's terms

Aligned Action cascades three **horizon success stories** into daily task selection: the **long-term** (5-year vision) sets direction, the **medium-term** (quarterly) is the bridge, and the **short-term** (weekly) is the live one that plan-my-day and WRAP read every day. **Foundations** — values, strengths, relationships — ground the choices, so the week serves what actually matters.

Full method: **https://help.maketimeflow.com** — the Aligned Action Framework, Time Horizons, the Task Trust System, and the Flourishing Map are all published there. This file is the operational summary, not a replacement. If a local methodology corpus is present on this machine, prefer it.

## Where intention lives

The ledger lives **in MakeTimeFlow**, read and written through the MCP:

- **Stories**: `list_stories` (no args) returns the current stack — per horizon, the active story or an in-window draft written ahead. `read_story` for full content + the watcher's evaluation feedback. `update_story` writes (whole body). Past stories are kept by the server automatically — **there is no archiving step**; history is the record.
- **Foundations**: `get_foundations` returns values (ordered), strengths, and relationships in one call, plus the canonical values catalog; `update_values` / `update_strengths` / `update_relationships` write them.
- **Reflections**: `list_reflections` returns what the user wrote at their rituals and in their journal — the only record of what happened *outside* tasks and timers. `create_reflection` records something back into the journal stream.

Trust the tool descriptions for parameters and semantics — this skill carries the workflow, not the schema.

## Foundations are load-bearing

The foundations are not a preamble to be read once and set aside. They are the reasoning substrate: they decide what gets chosen, when a horizon needs revisiting, and what to do on a day the user cannot start. Four moves, and each one changes what the playbooks actually do.

### Values are the tiebreak, named out loud

When two candidates both fit capacity and both serve the week, **the value decides — and you say which one, by name**. "This one, because it serves Craftsmanship" is the sentence; "this one seems more important" is not. Ordered position matters: `get_foundations` returns values most-important-first, and that order is the tiebreak order.

This is the one move that has to happen every single day, in triage and in plan-my-day, in the *reason* attached to each choice. Repeated exposure to your own top values, attached to concrete daily choices, is the whole mechanism — a values list nobody meets again is a decoration.

Never invent a value the user hasn't named, and never stretch one to fit. If the honest answer is "none of your named values pick between these", say that; it is useful information about the week.

### Stories beat targets, and there is a reason

Goal-setting works well for simple, well-understood work with clear feedback. Outside those conditions it misfires — narrowed focus, gamed numbers, motivation that dies with the metric (*Goals Gone Wild*, Ordóñez et al.), and for complex work where the method isn't known yet, learning-shaped goals beat performance-shaped ones. Knowledge work is exactly that case.

So when a user tries to write a metric target into a weekly story, **you can explain why outcome-shaped is the better instrument here** rather than merely preferring it — and name the conditions under which a hard number *would* be right (the method is known, the feedback is fast, the number isn't a proxy for the thing). See `success-story-coaching.md`.

### Strengths route work; they do not label people

Use strengths to answer *"which of these is easiest for this person to start right now"* — a scheduling question. Never as a claim about who someone is. "Play to your strengths" as a personality prescription is not well supported and this skill does not assert it; that work fits how you operate and is therefore easier to begin when you are depleted needs no theory at all.

The framing is diagnostic, never motivational: *"none of today's five touch how you actually work best — you're not unmotivated, you're mis-assigned."*

### Horizons: the job is maintenance, not authoring

Setting a five-year story is common. **Maintaining one is not, and that is where the value is** — a horizon nobody revisits decays into an artifact that guides nothing, which is a quieter failure than never writing one because it still looks filled.

So the recurring move is to *re-meet* a horizon, not to rewrite it: read it back to the user, ask whether it is still true, and change it only if they say it isn't. The WRAP re-touches the weekly story every week; quarter boundaries re-touch the medium-term; the long-term gets read aloud periodically. Staleness is detectable today — see below.

## Detect-and-prompt (unfilled stories)

Before a playbook leans on a horizon, check it's actually written. A story is **unfilled** if it is **missing from the current stack** OR **its content still reads as the untouched starter template** (the fill-in prompts intact, nothing personal in it — judge from the `read_story` content, and let a very low `word_count` raise suspicion). For an unfilled story a playbook needs, **stop and prompt**: offer the coaching in `success-story-coaching.md`, or — first run only — the legacy migration below.

## Staleness — a filled horizon can still be dead

Filled is not the same as current. Read the age of the words, not of the row:

- `list_stories` gives you `updated_at` and `word_count` per horizon — enough to *suspect* a horizon hasn't been touched in a long time. Note that `updated_at` moves when anything on the story changes, including its stage or its dates.
- `read_story` gives `content_updated_at` — when the **words** last changed. That is the number to judge on.

Rules of thumb, not thresholds to enforce: a **weekly** story older than its own week is stale by definition — the WRAP exists to replace it. A **quarterly** untouched since the quarter opened is worth re-meeting mid-quarter. A **five-year** vision that hasn't been read in months isn't wrong, it's just no longer doing anything.

When something is stale, **offer to re-meet it — read it back, ask if it's still true** — and never treat staleness as a failing or open with it. It is one line at the end of a WRAP or a setup check, not a nag, and never a gate on the day's work.

## Cold start — mirror and correct, never author

A new user's foundations are empty, and this skill does **not** run an authoring wizard. Asking someone to compose five values into a chat window is a worse experience than a blank form, and it fails for the same reason.

**Show them what they already appear to value, and let them correct it.** Correction is faster and more motivating than composition — recognition instead of recall, being seen instead of being interviewed.

1. **Gather evidence from what they already produced.** `list_reflections` (a month is a good window) for what recurs in their own writing; what actually got completed; where tracked time went (`time_spent_summary`). Not ratings — prose and behaviour.
2. **Map to the catalog.** `get_foundations` returns the predefined values with definitions; propose in those terms so the write round-trips cleanly.
3. **Propose two or three, tentatively, and say what they're built from.** Quote a little of the user's own writing back as the evidence. Being tentative is the design, not a hedge — a wrong guess corrected in five seconds still beats a blank form, and the correction *is* the data.

   > Reading back your reflections this month, two things keep showing up: you write about the deep work sessions as the good days, and you keep mentioning the one-to-ones. In the catalog those look closest to Craftsmanship and Growth. Do those sound like yours, or is that just how the month went?

4. **On their correction, write the full ordered list** with `update_values` (it replaces everything — include what they keep).

Three rules that make this safe to offer at all:

- **Offer once, and take no for an answer.** Declined means dropped for the session, not asked again more gently.
- **Never gate the day on it.** If they came to plan, plan. The mirror rides at the end, or waits.
- **Give them the door out of the chat.** A picker beats a conversation for this particular task: **https://my.maketimeflow.com/values**, and likewise `/strengths` and `/relationships`. Offer it in the same breath.

Strengths and relationships work the same way, from the same evidence — but they are a lighter touch, and relationships are **a noticing, never an account of hours**. Meaningful time with the people who matter is largely untracked by design, so any ledger of it understates exactly the relationships that matter most. Ask; don't tally.

## First run — migrate the legacy workspace

If the MakeTimeFlow stories/foundations are unfilled AND a legacy local `flow/` workspace exists with filled files, offer to migrate:

1. Read the local `horizons/*.md` and `foundations/*.md` that are filled (a file is filled unless missing or its first line is still `<!-- flow:template -->`).
2. Draft the migration in chat — which horizon gets which content, the values list in priority order, the strengths/relationships text.
3. On approval: `update_story` per horizon, `update_values` (the FULL ordered list), `update_strengths`, `update_relationships`.
4. Suggest the user retire the local workspace afterward (it no longer participates in the loop); leave the files untouched otherwise.

## Posture — draft, confirm, write

Reads are free. Every **write** is drafted in chat, approved, then executed. MakeTimeFlow writes pass the MCP `mcp:write` consent on top. Ledger-specific: stories are **whole-body** writes (read first; send the entire rewritten document; never append a second copy); `update_values` **replaces the full list** (call `get_foundations` first and include everything the user keeps); **committing a story (`update_story_stage`) happens only on the user's explicit ask** — writing content never commits or activates anything.

Reflections are the user's private writing about their own life. Reflect them back to the user and nowhere else, quote sparingly, and read `authored_by` before quoting — see the provenance gotcha in `mcp-tools.md`.
