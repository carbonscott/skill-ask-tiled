# skill-ask-tiled

Tiled data access service documentation assistant — a knowledge-wrapper skill
that searches a locally-mirrored copy of the Tiled documentation via an FTS5
index built by `docs-index`.

This repository is **externalized** and centrally deployed via the
[deploy-opencode](https://github.com/carbonscott/deploy-opencode) meta-deploy
(see `skills.manifest.json` and `deploy.sh`).

## Layout

```
.
├── README.md
├── claude/
│   └── skills/
│       └── ask-tiled/
│           ├── SKILL.md
│           ├── bin/                  # docs-index helper (script + python)
│           ├── env.local             # S3DF facility config (TILED_DOCS_ROOT)
│           ├── env.sh                # generic env loader (sources env.local)
│           └── setup.sh              # one-time skill setup helper
├── opencode/
│   └── skills/
│       └── ask-tiled/                # byte-identical duplicate of claude/skills/ask-tiled/
└── tools/
    └── tiled-docs/
        ├── env.sh                    # tool env (TILED_DOCS_APP_DIR, TILED_DOCS_DATA_DIR)
        └── scripts/
            └── tiled-docs-cron.sh    # weekly git pull + reindex
```

`claude/` and `opencode/` are byte-identical — Claude Code reads from `claude/skills/`
while opencode reads from `opencode/skills/`. The duplicate avoids any cross-runtime
shared/ indirection.

## Deploy targets

`deploy-opencode/deploy.sh ask-tiled` rsyncs:

| Source in this repo                | Destination on S3DF                                          |
|------------------------------------|--------------------------------------------------------------|
| `opencode/skills/ask-tiled/`       | `/sdf/group/lcls/ds/dm/apps/dev/opencode/skills/ask-tiled/`  |
| `tools/tiled-docs/`                | `/sdf/group/lcls/ds/dm/apps/dev/tools/tiled-docs/`           |

A symlink `opencode/agents/ask-tiled -> ../skills/ask-tiled` is created on first deploy.

## Cron schedule

The Tiled docs mirror is refreshed weekly. Crontab line installed manually
on `sdfcron001` (deploy.sh does **not** install crontab):

```
0 3 * * 0  /sdf/group/lcls/ds/dm/apps/dev/tools/tiled-docs/scripts/tiled-docs-cron.sh run >> /sdf/group/lcls/ds/dm/apps/dev/data/tiled-docs/cron.log 2>&1
```

Or use the helper:

```
tiled-docs-cron.sh enable    # install crontab entry
tiled-docs-cron.sh disable   # remove crontab entry
tiled-docs-cron.sh status    # show enabled state + recent log
```

The cron job: `git pull` the Tiled docs mirror, rebuild the FTS5 index with
`docs-index`, then `chgrp -R ps-data` for group-read access.

## Data dependency

Documentation data lives at `/sdf/group/lcls/ds/dm/apps/dev/data/tiled-docs/`
(out-of-band; managed by the cron job above, not by `deploy.sh`).

## License

Mirrors the deploy-opencode project license.
