# renovate-config

iwamot's shared Renovate preset.

## Usage

In your repository's `.github/renovate.json`:

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": ["github>iwamot/renovate-config"]
}
```

## Validation

```bash
./validate.sh
```

## Shared mise task updates

Updates to `iwamot/mise-tasks` git includes also refresh `mise.lock` and native dependency sidecars in the same PR. The post-upgrade task installs mise using the repository's `constraints.mise`, trusts the root `mise.toml`, and runs `mise lock`; existing locked platforms are retained. This includes task-header tools such as pinact and gh without declaring them again in every caller.

Self-hosted Renovate must allow exactly `mise trust mise.toml` and `mise lock` through `allowedCommands`. `iwamot/workflows` supplies this allowlist and derives `constraints.mise` from the caller's `min_version`. Direct tool updates continue to use Renovate's native mise manager.

Generated files under `.mise/locks/` are owned by mise, so their package manifests are excluded from independent dependency updates. Update the tool declaration in `mise.toml`; mise regenerates the matching version directory and sidecar digest together.
