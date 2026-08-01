# MakeTimeFlow MCP tools — when to use, and the gotchas

Everything lives in MakeTimeFlow: the ledger tools carry intention (stories + foundations) and the execution tools carry what's true right now (tasks, timers, time). Trust each tool's own description for parameters — this file is the flow-specific usage layer.

## Capacity first (the calc an LLM botches)

Always ground capacity with `assess_capacity` / `check_fit` before proposing a day — **do not estimate focused-work hours by hand.** Honor the realistic ceiling (~4h of focused work per day) and **leave white space**. A day planned past capacity is a planning failure, not ambition.

## Time-blocking syntax (gotcha)

To place a task as a real timed calendar block, `create_task` needs **both** `start_at` (ISO 8601) **and** `expected_duration` (minutes). A `start_at` *without* a duration will **not** render as a timed block. The same rule applies to `update_task`: to schedule a task that **already exists** onto the calendar, set both `start_at` and `expected_duration` on it — most of day-planning is this (scheduling existing tasks), not creating new ones. Use `x_factor` (with `start_at` + `expected_duration`) to materialize repeated sequential blocks (xBlocks) for deliberate, repeated focus. Use `task_type: "event"` for meeting-style time-commitments.

## The ledger rhythm (gotchas)

- **Read before write, write the whole body.** `update_story` replaces the entire story: `read_story` first, edit within the full text, send back the complete document with unchanged parts verbatim, and pass its `content_updated_at` so a write built on a version the user has since changed is refused rather than erasing them. Never send only a changed section; never append a second copy. Use `create_story` when the horizon has no story yet — `update_story` will refuse, on purpose, so a "create" can never land on top of one the user just wrote.
- **Feedback is the watcher's, and it takes a beat.** A story write returns `evaluation_status` and NULL evaluations — re-evaluation runs server-side (~30–60s). Give your own conversational impressions immediately; when the user wants the watcher's verdict, `read_story` after the beat and coach from its headline/suggestion/section-coverage. An evaluation flagged `stale: true` describes an earlier version of the words — never present it as current; re-poll instead. `stale: false` is trustworthy, so coach from that feedback without hedging: staleness tracks the CONTENT, so committing a story or fixing its dates doesn't make its feedback stale, and an edit landing while the watcher was still thinking does.
- **Committing is the user's gesture.** `update_story_stage` (draft / refine / committed) only on an explicit ask like "commit my weekly story" — committing activates the story for its horizon. Never as a follow-on to writing.
- **Planning ahead is native.** `period: "next"` addresses the upcoming draft for ANY horizon (next week, next quarter, the next five-year vision) — `create_story` to start it, `update_story` to revise it. No archiving — the server keeps history.
- **Rollover leaves a story stranded, and that is a coaching moment.** At a quarter or vision boundary the previous story stays active while its window ends, so `list_stories` shows it with `status: "active_past_window"`. Do not plan against it and do not quietly start a replacement — `create_story` would retire theirs. Ask which they meant: extend the window (`update_story_dates`) because the quarter really did run longer, or start the new one. Writing a `period: "next"` draft ahead avoids the gap entirely, which is the WRAP habit worth building.
- **Values are a full-list replace.** `get_foundations` first; `update_values` with everything the user keeps, most-important-first. Same read-first rule for `update_strengths` / `update_relationships` (whole-text replaces).
- **"Due this week" and "done this week" are different queries.** `@this_week` matches `start_at`/`deadline` — when work was *scheduled*. `completed:this_week` matches when it was *finished*. Reaching for the first to answer the second is silent and wrong.
- **Story age has two clocks.** `list_stories` carries `updated_at` — the row, which moves when the stage or the dates change. `read_story` carries `content_updated_at` — the **words**. Judge staleness on the words. See `aligned-action.md`.

## Reflections — the private corpus (gotchas)

`list_reflections` returns what the user wrote at their rituals (BeginWell, Shutdown, Weekly Planning), their journal entries, and their daily notes. It is the only record of what happened *outside* tasks and timers, and it is the evidence layer beneath foundations coaching.

- **Read `authored_by` before you quote anything.** Every row says `user` or `agent`. Text an assistant recorded earlier is **not** the user's words — quoting it back as theirs is how a coaching loop starts agreeing with itself. Say "I noted last week that…" for agent rows, and quote only user rows as *their* writing.
- **Quote sparingly, reflect back only to the user.** This is a private journal, not context to summarize outward.
- **What's absent is absent on purpose.** No mood or energy ratings come back, and the AI reflection conversation isn't a source. Don't narrate a trend from what you can't see, and don't treat a quiet week in the corpus as a quiet week in the life.
- **`create_reflection` writes to the journal, never onto a ritual.** It records something the system could not otherwise know — what the user said about how a week went, the evening that mattered, who drained them. Draft it, get an explicit yes, and write it **in their words**, not as a summary of your own advice. No byline: the row already records that an agent wrote it.

## Reference table — ledger (intention)

| Tool | Use in flow |
|------|-------------|
| `get_foundations` | Values + strengths + relationships in one call, plus the canonical predefined-values catalog (name, definition, category) — the menu to offer in a values conversation, and the vocabulary the mirror-and-correct cold start proposes in. Anchor plan-my-day and story coaching; the read-first step before any foundations write. Also carries `values_updated_at` / `strengths_updated_at` / `relationships_updated_at`, so foundations have an age too. |
| `list_stories` | No args = the current stack (per horizon: active story, or an in-window draft written ahead). The first intention read in both playbooks. |
| `read_story` | Full content + watcher evaluations (quality + structural section-coverage) + `content_updated_at` (when the words last changed). Mandatory before `update_story`; the poll target after one. Read again before writing if the user may have edited in the app since — the workspace editor and this skill are two writers on one document. |
| `create_story` | Start a horizon's FIRST story (or its first `period: "next"` draft). Refuses if one already exists — the user may have just written it in the app. |
| `update_story` | Whole-body rewrite of an EXISTING story; `period: "next"` for the upcoming draft. `expected_content_updated_at` (the `content_updated_at` you read) is REQUIRED — if the story moved underneath you the write is refused rather than erasing their edit. Most WRAP and coaching writes land here. |
| `update_story_stage` | The user's commit/refine/draft gesture — explicit ask only. |
| `update_story_dates` | Fix a window the user disagrees with ("my quarter runs through March"). |
| `update_values` / `update_strengths` / `update_relationships` | Foundations writes — full replaces, read-first. |
| `list_reflections` | The user's own reflective writing — rituals, journal, daily notes — over a window. The evidence for mirror-and-correct, and for noticing what recurs. Read the gotchas above before quoting any of it. |
| `create_reflection` | Record something the system could not otherwise know into the user's journal, in their words, on their explicit yes. |

## Reference table — execution

| Tool | Key params | Use in flow |
|------|-----------|-------------|
| `get_temporal_context` | (none) | Ground today, week boundaries, next event, working hours. First call in both playbooks. |
| `list_tasks` | `query` (MTF filters + free text) | Candidate set, e.g. `query: "@today"`, `@next`, `priority:high`. **`completed:<period>`** (today / yesterday / this_week / last_week / this_month / last_month) selects work *finished* in a window — the WRAP's account. **`followup:none` / `followup:has`** filter by the follow-up chain; **`followup:<task_id>`** reads how *that* task's loop was closed, including follow-ups already completed — the one thing no other query reaches. Every row carries `followup_from_task_id`, so a continuation is visible without a second call. |
| `assess_capacity` | `window` (today / this_week / …), `start_date`, `end_date` | Honest focused-work ceiling for the window. |
| `check_fit` | `task_ids[]` or `task_id`, `window` (default this_week) | Overcommit check for a proposed set; the single-task form judges against that task's deadline. |
| `create_task` | `title` (required, rich MTF text), `bucket`, `notes`, `parent_task_id`, `deadline`, `start_at`, `expected_duration`, `x_factor`, `task_type`, `subtasks[]` | Create a **new** task / time-block. Pair `start_at` + `expected_duration` to block. |
| `update_task` | `id` (required), plus fields to change | Edit an **existing** task: **schedule it onto the calendar** (`start_at` + `expected_duration`), reprioritize, refile, or re-parent. The primary way to time-block a task that already exists. |
| `time_spent_summary` | `period` (default this_week) | Where time **actually** went — the WRAP outcome figure. |
| `stalled_tasks` | `bucket` (default both), `min_age_days` | Surface avoided/abandoned/deferred for close-the-loops. |
| `complete_task` / `cancel_task` | task id | Close a loop / drop it deliberately. |
| `set_waiting_for` | `id`, `waiting_on` (optional) | Park a task as waiting; record who/what it's blocked on. |
| `add_followup` | `original_task_id`, `title` | Chain the next action — **the original task is marked complete** and the follow-up created. |
| `move_bucket` | `id`, `bucket` | Refile (e.g. into `@today`) — no time set; use `update_task` to schedule. |
| `start_timer` | `kind` (`focus`/`break`), `task_id`, `duration_minutes`, `label` | Run the declaration's last step (`intentional-timer.md`) — the close of both plan-my-day and triage. Links and **marks the task started**. `label` is ignored when `task_id` is given, and a focus timer without a task **requires** one. |
| `list_active_timers` | (none) | What's running, with `elapsed` / `remaining` / `overrun_minutes` and a `state`. Call it **before** starting — starting never stops a running timer — and on the return, where an overrun is usually the rabbit hole having happened. |
| `stop_timer` | `timer_id` (optional) | End a block; returns `actual_minutes`. With no id it stops the only running timer and errors, listing them, when several are. |

Also available, not central to the playbooks: `read_task` (with `depth`).

**Two running timers double-count into `time_spent_summary`** — the one figure the WRAP trusts. That is the reason `list_active_timers` comes first.

## Every write is drafted first

Creating or modifying anything — task, time-block, story, foundation — is a write: draft it, get a yes, then call the tool. See the posture in `aligned-action.md`.
