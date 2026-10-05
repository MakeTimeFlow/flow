# MakeTimeFlow MCP tools — when to use, and the gotchas

Everything lives in MakeTimeFlow: the ledger tools carry intention (stories + foundations) and the execution tools carry what's true right now (tasks, timers, time). Trust each tool's own description for parameters — this file is the flow-specific usage layer.

## Capacity first (the calc an LLM botches)

Always ground capacity with `assess_capacity` / `check_fit` before proposing a day — **do not estimate focused-work hours by hand.** Honor the realistic ceiling (~4h of focused work per day) and **leave white space**. A day planned past capacity is a planning failure, not ambition.

Committed time is the **union** of booked blocks, not their sum: two things holding the same hour cost one hour, because you can only be in one place at 2pm. `assess_capacity` reports the collision separately as `double_booked_minutes` — **mention it when it is non-zero**, since it usually means either a genuine conflict worth resolving or a calendar syncing the same event twice (which quietly makes every week look fuller than it really is).

## Time-blocking syntax (gotcha)

To place a task as a real timed calendar block, `create_task` needs **both** `start_at` (ISO 8601) **and** `expected_duration` (minutes). A `start_at` time *without* a duration gets only a default 25-minute block. When the user names a **day but no time** ("the 30th", "next Monday"), pass `start_at` as a bare date (`"2025-03-15"`) — that makes an **all-day** task on that day in the user's time zone, not a block. Don't invent a midnight time for it. The same rule applies to `update_task`: to schedule a task that **already exists** onto the calendar, set both `start_at` and `expected_duration` on it — most of day-planning is this (scheduling existing tasks), not creating new ones. Use `x_factor` (with `start_at` + `expected_duration`) to materialize repeated sequential blocks (xBlocks) for deliberate, repeated focus. Use `task_type: "event"` for meeting-style time-commitments. When the user asks to **put something on their calendar**, prefer `add_to_calendar`: it is the calendar gesture, so a project gets a "Work on" block rather than the project itself being scheduled (which is what `update_task` with a `start_at` does).

## Grouping (gotcha)

A **marker** draws a labelled line and **holds nothing** — tasks are never filed "under" it, and it groups only whatever happens to sit below it until the next row, which any sort or insert undoes. Reaching for a marker to gather related tasks is the most common way to produce organization that looks done and isn't.

To group tasks so they travel together, give them a shared **parent** via `parent_task_id`:

- **folder** — the group is pure organization and should never count as work ("Errands", "Paper feedback").
- **project** — finishing it means something was *achieved* ("Draft the HCOMP keynote").

The test is completable. When someone asks for "a section" or "a header" to organize tasks, they almost always mean a folder. Prefer a container they already have over creating a near-duplicate one.

`update_task` re-parents an existing task (`parent_task_id`), and `clear_parent: true` makes it top-level — passing `parent_task_id: null` does not.

## The ledger rhythm (gotchas)

- **Read before write, write the whole body.** `update_story` replaces the entire story: `read_story` first, edit within the full text, send back the complete document with unchanged parts verbatim, and pass its `content_updated_at` so a write built on a version the user has since changed is refused rather than erasing them. Never send only a changed section; never append a second copy. Use `create_story` when the horizon has no story yet — `update_story` will refuse, on purpose, so a "create" can never land on top of one the user just wrote.
- **Feedback is the watcher's, and it takes a beat.** A story write returns `evaluation_status` and NULL evaluations — re-evaluation runs server-side (~30–60s). Give your own conversational impressions immediately; when the user wants the watcher's verdict, `read_story` after the beat and coach from its headline/suggestion/section-coverage. An evaluation flagged `stale: true` describes an earlier version of the words — never present it as current; re-poll instead. `stale: false` is trustworthy, so coach from that feedback without hedging: staleness tracks the CONTENT, so committing a story or fixing its dates doesn't make its feedback stale, and an edit landing while the watcher was still thinking does.
- **Committing is the user's gesture.** `update_story_stage` (draft / refine / committed) only on an explicit ask like "commit my weekly story" — committing activates the story for its horizon. Never as a follow-on to writing.
- **Planning ahead is native.** `period: "next"` addresses the upcoming draft for ANY horizon (next week, next quarter, the next five-year vision) — `create_story` to start it, `update_story` to revise it. No archiving — the server keeps history.
- **Rollover leaves a story stranded, and that is a coaching moment.** At a quarter or vision boundary the previous story stays active while its window ends, so `list_stories` shows it with `status: "active_past_window"`. Do not plan against it and do not quietly start a replacement — `create_story` would retire theirs. Ask which they meant: extend the window (`update_story_dates`) because the quarter really did run longer, or start the new one. Writing a `period: "next"` draft ahead avoids the gap entirely, which is the WRAP habit worth building.
- **Values are a full-list replace.** `get_foundations` first; `update_values` with everything the user keeps, most-important-first. Same read-first rule for `update_strengths` / `update_relationships` (whole-text replaces).
- **"Due this week" and "done this week" are different queries.** `@this_week` matches `start_at`/`deadline` — when work was *scheduled*. `completed:this_week` matches when it was *finished*. Reaching for the first to answer the second is silent and wrong.
- **Story age has two clocks.** `list_stories` carries `updated_at` — the row, which moves when the stage or the dates change. `read_story` carries `content_updated_at` — the **words**. Judge staleness on the words. See `aligned-action.md`.

## Launching a ritual in the app

The rituals live in MakeTimeFlow, and you can **hand off into a real one** rather than only pointing at it. A task whose title contains a ritual keyword carries an action that opens that ritual when the task starts:

| Keyword in the title | Opens |
|---|---|
| `shutdown` | the Shutdown ritual |
| `wrap` (or "weekly planning" / "weekly reflection") | the Weekly Planning ritual — the WRAP |
| `begin` (or "begin well") | the BeginWell ritual |

**The handoff, in two calls:**

1. **Ask how long they want to give it** — and expect an underestimate. Fifteen minutes for a Shutdown, ten for BeginWell, thirty or more for a WRAP are realistic. Naming a length up front is what stops a ritual quietly becoming a five-minute skim.
2. `create_task` with a title carrying **the keyword and the duration** — `"Do shutdown 15m"`, `"Do wrap 30m"`, `"Do begin 10m"`. The duration sets the task's estimate.
3. `start_timer` with that `task_id` and **no** `duration_minutes` — it inherits the estimate from the title, so the number is stated once.

The app takes it from there: the timer is running, and the ritual opens. This is the closest the skill gets to feeling like one system rather than two.

> **It needs the app open.** The navigation happens in the MakeTimeFlow desktop or web app, not in this conversation. If they're not in the app, you've made them a timed task that will open the ritual whenever they do start it — say that, rather than implying something is happening on screen right now.

**The trap: these keywords fire on any task title.** "Begin drafting the proposal" and "Wrap up the quarter report" both match, and both would silently attach a ritual launch to an ordinary task. When creating tasks for any other purpose — triage, plan-my-day, a follow-up — **avoid opening a title with `begin`, `wrap`, or `shutdown`**. Reword it: "Draft the proposal", "Finish the quarter report".

## Reference table — rituals

| Tool | Use in flow |
|------|-------------|
| `get_ritual` | One ritual as it stands: the steps that apply today (key, label, done), the writing saved so far, Begin Well's focus, started/complete. Read before guiding a ritual; it never creates one. |
| `complete_ritual_step` | Tick one step by its key from `get_ritual`, as it finishes. Never changes completion. |
| `complete_ritual` | Finish the ritual: closes its calendar block and counts it as done for reminders. Idempotent. |
| `set_focus` | Today's focus (Begin Well's "decide on your focus"), optionally morning energy low/okay/high. Not a task highlight. |

## Reference table — calendar

The user's calendar is MakeTimeFlow's: their connected Google or Outlook calendars sync in as events, beside the time blocks they schedule. There is no separate calendar to look up.

| Tool | Use in flow |
|------|-------------|
| `read_calendar` | What's on the calendar for a day, or up to 7 days from a date: each item (title, from/to in their time zone, event or task, all-day, meeting, read-only, completed) and each day's free stretches. The read for "what's on Thursday" and "am I free tomorrow afternoon". |
| `list_calendars` | Which calendars are connected (Google, Outlook) and which one new items go to. Check it before promising a specific calendar. |
| `add_to_calendar` | Put something on the calendar: a new event by default (a meeting, lunch), `kind: "task"` for a time block of work, or an existing task by `task_id`. A project gets a "Work on <project>" block for one sitting and stays off the calendar itself; "work on #email" makes a tag block. Optional `calendar: google` or `outlook` (connected only); otherwise their default. The reply names what went where; say it back. |
| `move_on_calendar` | Reschedule something already on the calendar (by id from `read_calendar`), or `off_calendar: true` to take it off. A work block moves itself, never its project. Synced meetings are refused: those change with the organizer. |

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
| `assess_capacity` | `window` (today / this_week / …), `start_date`, `end_date` | Honest focused-work ceiling for the window. Committed time is the union of booked blocks; `double_booked_minutes` reports collisions separately. Also carries `energy`: the user's last self-reported mental energy (0–100) with `as_of` and `freshness`; `unknown` means there is no usable reading — do not assume one. |
| `check_fit` | `task_ids[]` or `task_id`, `window` (default this_week) | Overcommit check for a proposed set; the single-task form judges against that task's deadline. |
| `create_task` | `title` (required, rich MTF text), `bucket`, `notes`, `parent_task_id`, `deadline`, `start_at`, `expected_duration`, `x_factor`, `task_type`, `subtasks[]` | Create a **new** task / time-block. Pair `start_at` + `expected_duration` to block. |
| `update_task` | `id` (required), plus fields to change | Edit an **existing** task: **schedule it onto the calendar** (`start_at` + `expected_duration`), reprioritize, refile, or re-parent. The primary way to time-block a task that already exists. |
| `time_spent_summary` | `period` (default this_week), `group_by` (`flat` default / `tree`) | Where time **actually** went — the WRAP outcome figure. `flat` breaks the period down by task and by priority. `tree` follows the user's own outline — containers widening into their pieces, in their order, not by size — counts meetings that occupied time without a timer (attended vs unconfirmed, kept apart), and returns a one-sentence `summary` that is the same sentence the Week view shows. Reach for `tree` when the question is *where did the week go*; `flat` when you want the per-task rows. |
| `stalled_tasks` | `bucket` (default both), `min_age_days` | Surface avoided/abandoned/deferred for close-the-loops. Only scans `today`/`next` — moving something to `later` is a decision, not a stall — and anything touched, worked or completed in the last 7 days is excluded, so triage doesn't get reported back as stalling. |
| `complete_task` / `cancel_task` | task id | Close a loop / drop it deliberately. |
| `set_waiting_for` | `id`, `waiting_on` (optional) | Park a task as waiting; record who/what it's blocked on. |
| `add_followup` | `original_task_id`, `title` | Chain the next action — **the original task is marked complete** and the follow-up created. |
| `move_bucket` | `id`, `bucket` | Refile (e.g. into `@today`) — no time set; use `update_task` to schedule. |
| `read_tree` | `task_id` (optional) | The hierarchy as compact indented text — one branch, or the whole thing if you omit `task_id`. Use it over `read_task` when you want **structure**: `read_task` returns every field of every node and runs ~10x larger. Each line carries `id:N`. Re-read after anything moves; a tree you read earlier is stale. |
| `reorder_task` | `id`, `position` (`first`/`last`/`before`/`after`), `relative_task_id`, `within` (`parent`/`bucket`) | Change where a task sits in an order — **never** what it is filed under. Two orders: `parent` is its place among siblings in the outline, `bucket` is its place in the hand-arranged today/next list. Picking the wrong one looks to the user like nothing happened. Both tasks must already share a parent (or bucket). |
| `start_timer` | `kind` (`focus`/`break`), `task_id`, `duration_minutes`, `label` | Run the declaration's last step (`intentional-timer.md`) — the close of both plan-my-day and triage. Links and **marks the task started**. `label` is ignored when `task_id` is given, and a focus timer without a task **requires** one. |
| `list_active_timers` | (none) | What's running, with `elapsed` / `remaining` / `overrun_minutes` and a `state`. Call it **before** starting — starting never stops a running timer — and on the return, where an overrun is usually the rabbit hole having happened. |
| `stop_timer` | `timer_id` (optional) | End a block; returns `actual_minutes`. With no id it stops the only running timer and errors, listing them, when several are. |

| `read_repeating_tasks` | (none) | The user's repeating document — the text as they wrote it, the rhythms understood (with each one's next date), the lines that could not be read, `todays_lines`, and `assignment` (`automatic`, `assign_ahead`: `on_the_day` / `week` / `month`, `assigned_today`). **Call it in plan-my-day before proposing the day**: with `automatic` on, `todays_lines` are already on the list; with a horizon beyond the day, the week's time blocks are already on the calendar — don't re-create either. |
| `update_repeating_tasks` | `document` (the COMPLETE text) | Replace the whole document — read first, edit within the full text, send it all back. Headings: `Daily`, `Weekdays`, `Weekends`, day names or lists, `1st of the month`, `Last day of the month`, `March 14`; lines start with `- `; `#` lines are notes. Check `issues` in the response: an unknown heading is kept in the text, never dropped. Assignment settings are the user's, in the app — this tool never changes them. |
| `update_repeating_assignment` | `automatic` (boolean), `assign_ahead` (`on_the_day` / `week` / `month`) — **both required** | The page's two settings, with the page's side effects: turning `automatic` on assigns today's lines at once; a `week` or `month` horizon places the blocks at once. Settings with ongoing effects — read first, say what will change and what happens right away, get a yes. |
| `assign_repeating_tasks` | (none) | The Assign button: today's lines as real tasks, once per day. For a manual-mode user in plan-my-day, after they say yes. With `automatic` on it adds nothing. |
| `clear_repeating_blocks_ahead` | (none) | The "Clear them" link: **destroys** every untouched block placed ahead and frees the days; anything the user touched stays. Say how many will go and get an explicit yes. If they no longer want blocks ahead, also set `assign_ahead` to `on_the_day`, or the next hourly check places them again. |

Also available, not central to the playbooks: `read_task` (with `depth`) — the full-detail single-task read, where `read_tree` is the compact structural one.

**Two running timers double-count into `time_spent_summary`** — the one figure the WRAP trusts. That is the reason `list_active_timers` comes first.

## Every write is drafted first

Creating or modifying anything — task, time-block, story, foundation — is a write: draft it, get a yes, then call the tool. See the posture in `aligned-action.md`.
