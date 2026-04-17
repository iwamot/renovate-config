#!/bin/bash
set -e

# mise
eval "$(mise activate bash)"
mise fmt
mise install

# GitHub Actions
pinact run
zizmor --fix .github/workflows/
actionlint
ghalint run

# Renovate
renovate-config-validator --strict default.json

# Check for uncommitted changes
git diff --exit-code
