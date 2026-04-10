#!/bin/bash
# Site detection for ask-tiled skill.
# Sets TILED_DOCS_ROOT with a facility-appropriate default.
# Can always be overridden by setting TILED_DOCS_ROOT before sourcing.

if [ -d /sdf ]; then
    # S3DF (SLAC)
    export TILED_DOCS_ROOT="${TILED_DOCS_ROOT:-/sdf/group/lcls/ds/dm/apps/dev/data/tiled-docs}"
    export PATH="/sdf/group/lcls/ds/dm/apps/dev/bin:$PATH"
fi
