# Global git hooks

Installed as `~/.config/git/hooks` by `setup/create_links` and selected by
`core.hooksPath` in `git/config`. They apply to every repository on the
machine, including any LLM coding agent that runs git here.

## Requirements

1. **No accidental push to `main`, no accidental force push.** `pre-push`
   refuses pushes to `main`/`master` in shared repositories, refuses any
   non-fast-forward push, and always refuses deleting `main`/`master`.
2. **Repositories keep their own hooks.** `core.hooksPath` makes git ignore a
   repo's `.git/hooks`, so `_chain` runs them itself. A repo with a
   `.pre-commit-config.yaml` runs the framework directly via
   `pre-commit hook-impl`; `pre-commit install` is never needed and refuses
   under `core.hooksPath` anyway.
3. **No manual steps per repository.** Cloning is enough.

## Exemptions

- Personal repositories may push to `main`: a push URL owned by `dwwhitlock`
  on GitHub, or `git config hooks.protectedPushOk true` set in the repo.
- Force pushes to `refs/heads/dwightwhitlock/*` need no opt-in.
- Force pushes to `main` always need the opt-in, personal repo or not.

## Overrides

Environment variables on a single command, set by a human:

```
ALLOW_PROTECTED_PUSH=1 git push origin main
ALLOW_FORCE_PUSH=1     git pushf          # pushf = push --force-with-lease --force-if-includes
```

## Known gap

A repository that sets its own `core.hooksPath` (husky, lefthook) hides these
hooks for that repository. `~/code/status.sh` flags any such repo in its
`HOOKS` column.

## Files

| File | Role |
|---|---|
| `pre-push` | the guard, then hands off to `_chain` |
| `_chain` | runs the pre-commit framework and/or the repo-local hook for an event |
| `pre-commit`, `commit-msg`, … | one-line wrappers that call `_chain <event>` |
| `post-rewrite` | wrapper that buffers stdin before calling `_chain` |
| `test_pre_push` | 36 scenarios against throwaway repos; run after any change here or in `git/config` |
