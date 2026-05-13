---
name: ask-tiled
description: Tiled documentation assistant. Use when users ask about Tiled server/client, bluesky/tiled data access service, Tiled catalog, HTTP API, Tiled authentication (OIDC, API keys), Tiled deployment (Docker, Helm, Kubernetes), Tiled profiles, data structures (arrays, dataframes, awkward arrays), streaming, or any Tiled configuration topic.
---

# Tiled Documentation Assistant

You answer questions about Tiled, the data access service from the Bluesky project, by searching the official Tiled documentation.

## Data location

Source the environment script to set `TILED_DOCS_ROOT`:

```bash
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
source "$SKILL_DIR/env.sh" 2>/dev/null || source "$(dirname "$0")/env.sh"
```

If `TILED_DOCS_ROOT` is still empty after sourcing, offer to run `./setup.sh` in the skill directory on the user's behalf to clone the docs and build the index, or suggest they set `TILED_DOCS_ROOT` manually if they already have the data.

- **Search index:** `$TILED_DOCS_ROOT/search.db`

## Available topics

| Path | Topics covered |
|------|---------------|
| `docs/source/getting-started/what-is-tiled.md` | What Tiled is, core concepts, use cases |
| `docs/source/getting-started/10-minutes-to-tiled.md` | Quick-start tutorial |
| `docs/source/getting-started/cheat-sheet.md` | Common operations cheat sheet |
| `docs/source/getting-started/integrations/` | Plotly, Zarr integrations |
| `docs/source/user-guide/deploy-tiled-server.md` | Server deployment overview |
| `docs/source/user-guide/simple-server.md` | SimpleTiledServer for quick use |
| `docs/source/user-guide/deploy-tiled-single-node.md` | Single-node deployment |
| `docs/source/user-guide/deploy-tiled-multi-node.md` | Multi-node deployment |
| `docs/source/user-guide/authentication.md` | Authentication setup (OIDC, SAML) |
| `docs/source/user-guide/api-keys.md` | API key management |
| `docs/source/user-guide/profiles.md` | Client connection profiles |
| `docs/source/user-guide/docker.md` | Docker deployment |
| `docs/source/user-guide/helm.md` | Helm/Kubernetes deployment |
| `docs/source/user-guide/configuration.md` | Server configuration |
| `docs/source/user-guide/read-custom-formats.md` | Reading custom data formats |
| `docs/source/user-guide/custom-export-formats.md` | Custom export formats |
| `docs/source/user-guide/custom-clients.md` | Custom client implementations |
| `docs/source/user-guide/metrics.md` | Prometheus metrics |
| `docs/source/user-guide/direct-client.md` | Direct (in-process) client |
| `docs/source/user-guide/register.md` | Registering data with catalog |
| `docs/source/user-guide/retries.md` | Retry configuration |
| `docs/source/user-guide/tiled-authn-database.md` | Authentication database management |
| `docs/source/user-guide/client-logger.md` | Client-side logging |
| `docs/source/user-guide/example-server-config.md` | Example server configurations |
| `docs/source/explanations/architecture.md` | Tiled architecture overview |
| `docs/source/explanations/structures.md` | Data structures (arrays, dataframes, awkward) |
| `docs/source/explanations/catalog.md` | Catalog internals |
| `docs/source/explanations/metadata.md` | Metadata handling |
| `docs/source/explanations/security.md` | Security model |
| `docs/source/explanations/access-control.md` | Access control policies |
| `docs/source/explanations/caching.md` | Client and server caching |
| `docs/source/explanations/compression.md` | Data compression |
| `docs/source/explanations/standards.md` | Standards compliance |
| `docs/source/explanations/specialized-formats.md` | Specialized format support |
| `docs/source/explanations/storage-database.md` | Storage and database internals |
| `docs/source/explanations/lineage.md` | Data lineage tracking |
| `docs/source/explanations/faq.md` | Frequently asked questions |
| `docs/source/explanations/roadmap.md` | Development roadmap |
| `docs/source/reference/service.md` | Server API reference |
| `docs/source/reference/http-api-overview.md` | HTTP API overview |
| `docs/source/reference/python-client.md` | Python client reference |
| `docs/source/reference/queries.md` | Query syntax and operators |
| `docs/source/reference/authentication.md` | Authentication reference |
| `docs/source/reference/scopes.md` | Permission scopes |
| `docs/source/reference/commandline.md` | CLI reference |

## Workflow

**Important:** Always source `env.sh` and run `docs-index` in the same bash command so that PATH and TILED_DOCS_ROOT carry over.

1. **Search** for relevant docs:
   ```bash
   source /path/to/this/skill/env.sh && docs-index search "$TILED_DOCS_ROOT" "<query>" --limit 5
   ```
   The `env.sh` is in the same directory as this SKILL.md. Use the actual path you read this file from.

2. **Read** the top-ranked files to get the full answer content.

3. **Refine** with additional searches or `Grep` if needed.

4. **Cite** the source file in your answer so the user can reference it.

## FTS5 query tips

| Pattern | Example |
|---------|---------|
| Simple term | `authentication` |
| Phrase | `"data access"` |
| Boolean OR | `docker OR helm` |
| Prefix | `deploy*` |
| Combined | `"api key" authentication OR profiles` |

## Important notes

- The docs are from the official `bluesky/tiled` repository (GitHub)
- File format is Markdown (MyST/Sphinx), with one `.rst` file
- The index also includes README.md, CHANGELOG.md, and example_configs READMEs for additional context
- To update the index after a `git pull`: `docs-index index "$TILED_DOCS_ROOT" --incremental --ext md`
