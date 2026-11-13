#!/bin/sh
# The `lint` check: installs the locked dependencies with pnpm, then runs the repository's own linters: the
# `lint` script (next lint, configured by .eslintrc.json) and prettier --check over the tree (prettier.config.js,
# with .gitignore and .prettierignore). Static checks only, nothing is built.
# yggdrasil.yml runs it in the pinned Node image from the repository's root. By hand, from anywhere in the checkout:
#   docker run --rm -v "$PWD:/src" -w /src <image> sh ci/lint.sh
set -eu

# The repository's root, wherever this is run from.
cd "$(dirname "$0")/.."

# pnpm-lock.yaml is lockfile version 6.0: pnpm 8 reads it as it is.
pnpm() { npx --yes "pnpm@8.15.9" "$@"; }

export NEXT_TELEMETRY_DISABLED=1

# The store outside the checkout: on a mounted checkout pnpm would otherwise put it at the mount's root.
pnpm install --frozen-lockfile --store-dir "${TMPDIR:-/tmp}/pnpm-store"
pnpm lint
pnpm exec prettier --check .
