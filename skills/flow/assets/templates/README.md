# flow workspace (legacy — migration source only)

An earlier version of the `flow` skill kept your Aligned Action workspace here, in local files. **It no longer does.** Intention now lives in MakeTimeFlow itself — the horizon success stories and the foundations are read and written over the MCP, so they reach every device and every client, not just this machine.

These files are kept for one purpose: if this workspace has real content in it and your MakeTimeFlow horizons are still empty, the skill offers to **migrate it up** on first run. After that, retire the folder.

## Layout

```
flow/
  README.md                 # this file
  horizons/
    long-term.md            # 5-year vision (success story)
    medium-term.md          # quarterly success story
    short-term.md           # weekly success story — the live one
    archive/                # dated past weekly/quarterly stories
  foundations/
    values.md
    strengths.md
    relationships.md        # key relationships
  experiments/              # v2: personal-experiments.md · smart-bets.md · results.csv
```

## What migrates where

- `horizons/*.md` → the matching long / medium / short-term success story in MakeTimeFlow.
- `foundations/values.md` → your ordered values list; `strengths.md` and `relationships.md` likewise.

A file counts as filled unless it's missing or its first line is still `<!-- flow:template -->`. Nothing is migrated without you seeing the draft and saying yes, and the local files are left untouched either way.

Once it's up, the foundations are not decoration: your values become the tiebreak the daily plan names out loud, and your horizons get re-met rather than left to go stale.

## Privacy

This folder can hold sensitive values and relationships. `flow` offers to gitignore it (all of `flow/`, or just `foundations/`) when it first sets up the workspace.
