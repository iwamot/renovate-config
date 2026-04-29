#!/bin/bash
set -e

# mise
eval "$(mise activate bash)"
mise fmt
mise install

# Shared lint tasks
mise run gha-lint
mise run shell-lint

# Renovate
renovate-config-validator --strict default.json

# Check for uncommitted changes
git diff --exit-code
