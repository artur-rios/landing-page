#!/bin/sh
# The `build` check: installs the locked dependencies with pnpm and makes the production build with the `build`
# script (next build). The repository has no tests. Nothing is deployed: the point is that the site still builds.
# yggdrasil.yml runs it in the pinned Node image from the repository's root. By hand, from anywhere in the checkout:
#   docker run --rm -v "$PWD:/src" -w /src <image> sh ci/build.sh
set -eu

# The repository's root, wherever this is run from.
cd "$(dirname "$0")/.."

export NEXT_TELEMETRY_DISABLED=1

# pnpm-lock.yaml is lockfile version 6.0: pnpm 8 reads it as it is.
pnpm() { npx --yes "pnpm@8.15.9" "$@"; }

# The store outside the checkout: on a mounted checkout pnpm would otherwise put it at the mount's root.
pnpm install --frozen-lockfile --store-dir "${TMPDIR:-/tmp}/pnpm-store"
pnpm build
