# Coaching a success story

Help the user write a **present-tense, vivid, outcome-focused** success story — one that names what good looks like, not a list of tasks. The published method is at **https://help.maketimeflow.com** (Key Concepts, and the Aligned Action Framework). This guide is the operational move-set. If a local methodology corpus is present on this machine, prefer it.

## Weight: the weekly story

v1 coaching is weighted to the **weekly (short_term) story** — rewritten every WRAP, and the one the daily loop actually consumes. The long- and medium-term horizons get a **light first pass** only here; deeper authoring of them is deferred to v2.

## How to coach (weekly)

1. **Anchor up.** `read_story` on the medium_term story and `get_foundations` for values; the week should serve them. If either is unfilled, note it but don't block — a weekly story can still be written.
2. **Ask for outcomes.** "What are the 2–4 outcomes that would make this a genuinely great week?" Push for outcomes (what's true at week's end), not activities (what you'll do).
3. **Convert to success language.** Rewrite each as present-tense, as if it already happened ("It's Friday and…"). Concrete and specific beats abstract.
4. **Check it.** Does it name outcomes rather than a task list? Is it the *few* that matter, not everything? Is it honest about capacity? Does it name the values it serves?
5. **Write it.** Draft in chat → approval → `update_story` (whole body; `period: "next"` when writing the upcoming week from a WRAP, `current` when revising the live one). Preserve the user's own structure — some stories have sections, some are one narrative.
6. **Close the feedback loop.** The watcher re-evaluates after the write (~30–60s; the response's `evaluation_status` says whether it queued). Give your own read immediately; when the user wants the watcher's verdict, `read_story` and coach from its headline, suggestion, and section coverage.

## Light pass (long / medium)

When a long- or medium-term horizon is needed but unfilled, offer a quick first draft — don't run the full deep process (that's v2):

- **Long-term (5-year):** "Five years out, what does a successful life/work look like — in a few vivid present-tense sentences?" Capture via `update_story`; mark in conversation as a first pass to revisit.
- **Medium-term (quarter):** "What would make this quarter a clear step toward the 5-year story?" Two or three present-tense outcomes, written the same way.

## Always draft into chat first

Draft the story in chat; the user approves before `update_story` is called (draft → confirm → write). Never write a story silently, and never commit/activate as part of writing — `update_story_stage` is its own explicitly-requested moment.
