# Contributing

## Run it from disk

Load the plugin without installing it:

```bash
claude --plugin-dir /path/to/flow
```

`/reload-plugins` picks up changes to a `SKILL.md` mid-session. Changes to `.mcp.json` or the manifests need a restart.

`--plugin-dir` is the only loop where edits are genuinely live. Marketplace installs — **including from a local path** — are copied into `~/.claude/plugins/cache/`, so the installed copy is a frozen snapshot of the working tree at install time. Editing the working copy does nothing to it.

Cowork has no `--plugin-dir`, so dogfooding there means installing from a local marketplace and re-snapshotting after each change:

```bash
claude plugin marketplace add /path/to/flow   # once
claude plugin install flow@maketimeflow       # once
# after every edit:
claude plugin marketplace update maketimeflow
claude plugin update flow@maketimeflow
```

Check which snapshot is actually loaded with `claude plugin list` — the version shown is the commit SHA the cache was built from.

## Before pushing

```bash
skills/flow/.lint.sh      # structural lint
claude plugin validate .  # manifest + structure
```

`validate` warns that no `version` is set. That is deliberate — see below.

The lint's tool check verifies every MCP tool named in `references/mcp-tools.md` still exists in the MakeTimeFlow server repo. It looks in `~/code/maketime/maketimeflow-server`, override with `MAKETIMEFLOW_SERVER=`, and reports `SKIP` rather than failing when the repo isn't on the machine — so it guards during development and stays quiet in CI.

## Pointing at a different server

The bundled `.mcp.json` declares production. To work against another environment, disable this plugin's server and add your own. Don't run both at once: Claude sees two near-identical toolsets and can't tell which account it is acting on.

## Versioning

`version` is deliberately unset in `plugin.json`. Claude Code then uses the git commit SHA as the version, so every push reaches installed users without a bump — the right trade while the plugin is in beta and moving fast. Setting an explicit semver is a deliberate change of release cadence: from then on, users get nothing until you bump it, so it comes with a `CHANGELOG.md`.

## What belongs in this repo

This plugin carries **choreography** — when to WRAP, the plan-my-day sequence, the draft-confirm-write posture. It deliberately does **not** restate tool parameters or story-structure vocabulary. Those live in the MakeTimeFlow server's own tool descriptions, where they are always current, reach every client, and are covered by the server's tests. If something needs saying about a tool, say it in that tool's description, not here.

Two consequences worth stating plainly, because this repo is public:

- **No private paths, hosts, or repo names.** The skill must work for someone who has nothing but a MakeTimeFlow account. Where the method needs citing, cite <https://help.maketimeflow.com>. A local methodology corpus may be preferred when present, but is never named by path. The lint fails the build if an internal hostname or repo name appears.
- **No copied method text.** The published help site is the canonical public expression; this repo summarises and points, it does not duplicate.

## Skill layout

See [`skills/flow/README.md`](skills/flow/README.md) for what each file in the umbrella skill carries, and the rule it lives by.
