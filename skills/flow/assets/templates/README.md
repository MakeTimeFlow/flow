# flow workspace

Your local Aligned Action workspace. The `flow` skill reads and writes these files to plan your day and run the weekly WRAP.

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

## How flow uses it

- **plan-my-day** reads `horizons/short-term.md` (primary; medium/long for context) and proposes a realistic, aligned day.
- **weekly WRAP** holds where time actually went against `horizons/short-term.md`, then drafts next week's story and archives the old one to `horizons/archive/`.
- **foundations** are read-if-present, so the weekly story can `[[wikilink]]` the values it serves.

## Privacy

This folder can hold sensitive values and relationships. `flow` offers to gitignore it (all of `flow/`, or just `foundations/`) when it first sets up the workspace.
