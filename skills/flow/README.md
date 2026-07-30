# flow skill — internals

The umbrella skill: the Aligned Action daily loop, read and written live in MakeTimeFlow over the MCP. Claude invokes this one automatically when the user says "plan my day", "weekly review", "write my success story", and similar. The typed doors in `skills/setup`, `skills/plan-my-day`, and `skills/wrap` are thin routers into the same playbooks.

Installation and user-facing docs live in the [repo README](../../README.md).

## Layout

| Path | What it carries |
|------|-----------------|
| `SKILL.md` | The way in brief, the interaction posture, and the entry-point routing table |
| `references/plan-my-day.md` | The daily playbook, step by step |
| `references/weekly-wrap.md` | The weekly WRAP playbook, step by step |
| `references/success-story-coaching.md` | Outcome-shaped story drafting across the three horizons |
| `references/aligned-action.md` | The framework, how each foundation is load-bearing, unfilled **and stale** horizon detection, the mirror-and-correct cold start, legacy-workspace migration |
| `references/mcp-tools.md` | Which tool to reach for, and the gotchas that bite |
| `assets/templates/` | Starter templates carrying the `<!-- flow:template -->` sentinel that marks a horizon unfilled |

## The rule this skill lives by

**Choreography here; vocabulary in the tools.** Tool parameters and story-structure semantics live in the MakeTimeFlow server's tool descriptions — they are always current, they reach every client, and they are guarded by the server's own tests. This skill carries only *when* and *in what order*. When a reference file starts explaining what a parameter means, that text belongs in the tool description instead.

The published method is **https://help.maketimeflow.com**, and that is what the skill points users at. A local methodology corpus, if one is present on the machine, is preferred over the summary — but it is never named by path and never copied in. This repo is public; the skill must work for someone who has only their MakeTimeFlow account.

## Lint

```bash
skills/flow/.lint.sh
```

Checks required files, frontmatter, that every `references/*.md` named in `SKILL.md` resolves, that templates carry the sentinel, and that every MCP tool named in `mcp-tools.md` still exists in the server repo. The last check skips with a warning when the server repo is not on the machine, so it guards during development and stays quiet in CI.
