# flow — the MakeTimeFlow plugin for Claude

Plan your day, get out from under the pile, start focused work you actually finish, and run your weekly review — **the MakeTimeFlow way**, with Claude working from your real tasks, your real calendar, and your actual success stories rather than a blank slate.

The point isn't a tidier list. It's more of your day spent in flow.

This plugin gives Claude two things: a connection to your MakeTimeFlow account, and the choreography for using it well.

Works in **Claude Code** and **Claude Cowork**.

> Using Claude on the web, desktop, or mobile instead? You don't need this plugin — connect MakeTimeFlow as a connector. See [Connect Claude and AI agents](https://help.maketimeflow.com).

## Install

```
/plugin marketplace add MakeTimeFlow/flow
/plugin install flow@maketimeflow
```

Then connect your account:

```
/mcp
```

Choose **maketimeflow**. Your browser opens to sign in with your normal MakeTimeFlow account and approve access. Grant **read and write** — write is what lets Claude actually create tasks, block time, and save your success stories. Read-only works too if you'd rather just let it look first.

Finally, check everything is wired up:

```
/flow:setup
```

## What you can ask for

| Type this | What happens |
|---|---|
| `/flow:setup` | Checks the connection and whether your horizons are ready to plan from |
| `/flow:triage` | Gives every task a home — today, next, parked with a name and a return date, waiting on someone, or honestly dropped |
| `/flow:plan-my-day` | Reads this week's success story, grounds your real capacity, proposes a realistic aligned day |
| `/flow:focus` | Sets up a focus block properly — what done looks like, why it matters now, what you'll do when you get pulled off — then runs the timer |
| `/flow:wrap` | Accounts for what you actually delivered, names the gap honestly, gives everything still open a home, writes next week |
| `/flow:loop-check` | Finds work marked done whose outcome never landed — the reply that never came, the handoff nobody picked up |

You can also just say it — "plan my day", "what should I work on", "I'm drowning", "I can't get started", "have I dropped something", "let's do my weekly review", "help me write my success story" — and Claude will pick up the right playbook on its own.

## What it actually does

**Triage** is for the days there's too much. Rather than helping you pick harder, it goes through the whole pile and gives every single task a home — today, next, later, waiting on someone, or honestly dropped. That's the part that produces the relief: an unfinished thing keeps nagging until it has a specific plan, and it stops once it has one, whether or not you've done it.

It also knows the difference between *"I've decided not to do this"* and *"I've decided not to decide now."* When a big block of things is real but not for this month, it doesn't push you to kill them — it parks them together in a folder you name, with a date you'll look again, so they're out of your way without being pretended away. You approve the whole disposition at once, and it ends by starting a timer on the first real thing. Works fine on day one, with nothing set up but your tasks.

**Plan my day** reads your current story stack and foundations, pulls your candidate tasks, and asks MakeTimeFlow for an *honest* capacity number rather than guessing. It proposes a few tasks that serve the week's story, fit inside real capacity, and leave white space — then offers to start the first focus block. An overfull day is a planning failure, not ambition.

**Focus** is for when you know what to do and can't make yourself start. It doesn't just run a timer — it takes a short declaration first: what done looks like, why this matters right now, and specifically what you'll do when the thing that always pulls you off pulls you off. That last part is the one with the strongest evidence behind it, and it only works if it's specific. Then the timer runs against that. Come back and ask how it went, and it'll tell you whether you ran over — and hold you to the guard you set, without the lecture.

**Weekly WRAP** starts with the account: what you actually delivered this week, and where your hours really went, from your tracked time rather than anyone's memory. Then the gap — held against what the week's story said it would be, and labelled honestly as either a one-off or the shape your weeks keep taking, because only one of those is worth changing anything over. Then everything still open gets a home, so a long list stops feeling like a threat. Then next week's story, carrying the lesson.

The order is deliberate. A review that opens on what you missed is a weekly guilt artifact, and people quietly stop doing those. This one is built to leave you with *"intense week, but good — I used my time well, and I know where I'm going."*

Every so often — not weekly — it does one more thing. If your quarterly or five-year story has gone untouched long enough to stop guiding anything, it reads it back to you and asks whether it's still true, rather than asking you to write a new one. Setting a long-term vision is easy and everyone helps you do it; keeping one alive is the part nothing else bothers with. And occasionally it'll notice a person who keeps appearing in your own reflections and simply ask about them — never a tally of hours, because the evenings that matter most are exactly the ones no tracker ever sees.

**Loop-check** goes after the quietest failure there is: work you marked done whose *outcome* never arrived. The proposal you sent that nobody replied to, the handoff nobody picked up. Nothing about those is overdue or stalled — the task says done — so they never appear on any list. It finds the completed work with nothing carrying it forward, then uses judgment rather than handing you a list: most finished things are simply finished, and it only raises the ones whose result was supposed to land somewhere else.

**Story coaching** drafts outcome-shaped success stories across all three horizons — the five-year vision, the quarterly bridge, and the live weekly one — and folds in the feedback MakeTimeFlow's own story watcher gives them.

## How it behaves

**Reads are free; every write is drafted first.** Claude will show you the tasks it wants to create, the time it wants to block, or the story it wants to save — and wait for your yes. Nothing changes in your account silently.

**Committing a story is always your gesture.** Writing a success story never activates it. Claude only commits one when you explicitly say so.

## Requirements

- A [MakeTimeFlow](https://maketimeflow.com) account
- Claude Code, or Claude Cowork

The MCP connection is currently in **beta**.

## Turn on updates

This plugin is improving quickly, so it's worth taking one extra step to get fixes as they land:

1. Run `/plugin`
2. Go to **Marketplaces** and select **maketimeflow**
3. Choose **Enable auto-update**

Claude Code only auto-updates its own marketplaces by default, so without this you stay on the version you installed. With it on, Claude Code refreshes shortly after each session starts and either tells you to run `/reload-plugins` or picks up the new version next launch.

Prefer to update by hand? Run these whenever you want the latest:

```
/plugin marketplace update maketimeflow
/plugin update flow@maketimeflow
```

## Learn the method

The plugin runs the method; [help.maketimeflow.com](https://help.maketimeflow.com) explains it — the Aligned Action Framework, the three time horizons, the Task Trust System, and the Flourishing Map.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for running the plugin from disk, the lint, and what does and doesn't belong in this repo.

## License

MIT — see [LICENSE](LICENSE).
