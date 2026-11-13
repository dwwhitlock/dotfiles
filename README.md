# dotfiles

Shell, git and terminal config. Works on macOS and Linux shells; the iTerm2 parts are macOS-only.

## Setting up a new machine

Steps marked **manual** can't be scripted.

1. **Manual: install Homebrew** with the official installer from <https://brew.sh>, then follow the "Next steps" it prints, which add `brew shellenv` to `~/.zprofile`. On Linux, `setup/apt_install` does both. `~/.zprofile` is left out of the repo on purpose; see `CLAUDE.md`.
2. **Manual: clone this repo** to `~/code/dotfiles`. `.zshrc` expects that path.
3. **Install packages:** `setup/brew_install` (runs `brew bundle` on the `Brewfile`).
4. **Link the dotfiles:** `setup/create_links` (`~/.zshrc`, `~/.gitconfig`, `~/.gitignore`, `~/.config/starship.toml`).
5. **Configure gpg:** `setup/configure` points gpg-agent at `pinentry-mac`. Safe to re-run.
6. **Manual: import your GPG signing key.** `git/config` signs every commit and tag with key `C8682424579A5DC5`, so commits fail until the key is in your keyring (`gpg --import`).
7. **Install Python versions:** `setup/python_install`.
8. **Manual: install Claude Code** with Anthropic's native installer (see <https://claude.com/claude-code>). It's one of only two tools not installed through brew; see `CLAUDE.md`.
9. **Manual: stop Rancher Desktop editing `.zshrc`.** On first launch, Rancher Desktop adds a "MANAGED BY RANCHER DESKTOP" block to `~/.zshrc` (which is this repo's file). In Rancher Desktop → Preferences → Application → Environment, set **PATH Configuration** to **Manual**, then delete the block it added. `.zshrc` already puts `$HOME/.rd/bin` on `PATH` itself.
10. **Set up iTerm2.** See the next section.
11. **Editor terminals:** `setup/editors --apply` (quit PyCharm first). See "Editor terminals" below.
12. **Claude Code settings:** `setup/claude --apply`. See "Claude Code" below. Run any other installer that manages Claude settings first, so this one can see which settings it owns.
13. **Repo status job:** optionally create `~/.config/code-status/env` (see "Repo status job" below), then `setup/launchd`.
14. Open a new terminal.

## iTerm2

### Automated: `setup/iterm2`

`iterm2/dotfiles.json` is an iTerm2 [Dynamic Profile](https://iterm2.com/documentation-dynamic-profiles.html). It sets only what this repo needs; everything else is iTerm2's default:

| Setting | Why |
| --- | --- |
| Left Option key → Esc+ | Makes the `⌥` (Option) shortcuts in `HOTKEYS.md` work |
| Font → MesloLGS NF 16 | starship's prompt icons need a Nerd Font (`font-meslo-for-powerlevel10k` in the `Brewfile`) |

`setup/iterm2` symlinks the profile into `~/Library/Application Support/iTerm2/DynamicProfiles/` and makes it the default profile.

**Run it with iTerm2 quit, from Terminal.app.** iTerm2 saves its preferences when it exits, which would undo the default-profile change. The script refuses to run while iTerm2 is open.

To change the profile, edit the JSON. iTerm2 reloads it live. Changes made in the Settings UI to a Dynamic Profile are not saved.

### Manual

- **Start from clean defaults (existing installs only).** A Dynamic Profile takes any setting it doesn't specify from iTerm2's default profile at load time. On a fresh install that's iTerm2's built-in defaults. On a machine where iTerm2 was already customised, the old customisations carry over. To start clean, quit iTerm2 and run `defaults delete com.googlecode.iterm2` **before** `setup/iterm2`. This erases all iTerm2 settings, so export anything you want to keep first.
- **macOS permissions.** Grant them when iTerm2 asks (System Settings → Privacy & Security). Nothing in this setup needs one, but Full Disk Access is useful for commands that read protected folders.
- **Shell integration (optional).** Install it from the iTerm2 menu → Install Shell Integration. It isn't in the repo because its installer is a `curl | bash` script.
- **Shift+Enter for Claude Code.** Run `/terminal-setup` inside Claude Code once. It adds a global iTerm2 key mapping so Shift+Enter inserts a newline in Claude Code's prompt. The repo leaves this to Claude Code because the tool owns that setting (see "No diffs from normal use" in `CLAUDE.md`).
- **Font already installed by hand?** If `MesloLGS NF *.ttf` files are already in `~/Library/Fonts`, `brew bundle` will refuse to overwrite them. Delete those four files, then re-run `setup/brew_install`.

## Editor terminals

The terminals built into editors need the same two settings as iTerm2: **Option sends Esc+**, so the `⌥` (Option) shortcuts in `HOTKEYS.md` work, and **a Nerd Font**, so starship's icons show.

### Automated: `setup/editors`

The desired settings live in `editors/`, one file per editor, in that editor's own format:

| File | Applied to | Settings |
| --- | --- | --- |
| `editors/vscode.json` | VS Code user `settings.json` | Option as Meta, terminal font |
| `editors/zed.json` | `~/.config/zed/settings.json` | Option as Meta, terminal font, editor font fallback (so Nerd Font icons in files like `starship/starship.toml` display instead of `?`) |
| `editors/pycharm.json` | `options/terminal.xml` and `options/terminal-font.xml` in the newest PyCharm config folder | Option as Meta, terminal font |

```sh
setup/editors           # report what differs; writes nothing
setup/editors --apply   # fix only those keys
```

The editors keep owning their settings files, so changing settings in an editor's UI never creates a repo diff. The script changes only the keys listed in `editors/`. Everything else in the file, including your comments, stays as it is. Before writing, it saves a backup to `~/.cache/dotfiles/editor-backups/`. It skips editors that aren't installed.

**Quit PyCharm before `--apply`.** PyCharm overwrites its settings files when it exits. The script refuses to edit them while PyCharm is running, or when it can't tell. VS Code and Zed pick up the changes live.

### Manual

- **PyCharm:** keep **Override IDE shortcuts** on (Settings → Tools → Terminal) so keys like `⌃R` and `⌃T` reach the shell. It's on by default.

## Claude Code

`claude/settings.json` holds my personal Claude Code user settings: model, plugins, and the SessionStart hook for `bin/code-session-summary`. It is **merged into** `~/.claude/settings.json`, never symlinked, because Claude Code writes to that file itself and other installers may merge their own settings into it.

```sh
setup/claude              # show what would change; writes nothing
setup/claude --apply      # back up, then merge
setup/claude --uninstall  # back up, then remove exactly what was merged
```

- **Merge rules:** objects merge, lists are unioned, scalars from `claude/settings.json` win. What was merged is recorded in `~/.claude/dotfiles.manifest.json`, so a setting deleted from the repo is removed on the next `--apply`, and a value it overwrote is put back.
- **Other installers win.** Any other `*.manifest.json` with an `installed` object in `~/.claude` marks settings another tool owns. `setup/claude` refuses to overwrite their values; it may only add list entries and new keys. Keep permissions, sandbox and safety settings out of `claude/settings.json`.
- **Re-run after editing** `claude/settings.json`. Backups go to `~/.cache/dotfiles/claude-backups/`.

## Repo status job

`bin/code-status` reports git state across every repo under `~/code` and, with `--report`, writes `~/code/ACTIVITY.md`: my WIP branches, my open PRs (stalest first), review requests, and which repos are active. `--expire` closes my PRs idle for 45 days, with a comment. Flags and settings are documented in the script header.

`setup/launchd` installs every plist in `launchd/` as a launchd agent. `local.code-status` runs `code-status --pull --report --expire --notify` every Monday, Wednesday and Friday at 08:00 and posts a notification that opens `ACTIVITY.md`. Log: `~/Library/Logs/code-status.log`. Re-run `setup/launchd` after editing a plist; edits to the script itself need nothing.

`bin/code-session-summary` is a Claude Code SessionStart hook (registered by `setup/claude`). In sessions under `~/code` it shows the one-line summary the last run wrote (`~/code/.activity-summary`).

Settings that aren't public go in `~/.config/code-status/env`, which is sourced as shell and not part of this repo:

```sh
CODE_STATUS_GH_OWNER=my-org   # only search PRs owned by this GitHub org/user (default: all of GitHub)
CODE_STATUS_OPEN_APP=Zed      # app the notification opens ACTIVITY.md in
```

Per-machine exceptions to `--expire` go in `~/code/pr-keep.txt`, one `<owner>/<repo>#<number>  <reason>` per line.

## Tearing down to test a full rebuild

**Easiest: don't tear down your main account.** Create a new macOS user (System Settings → Users & Groups) or a macOS VM and run the setup steps there. A new user starts with an empty home directory and default app settings, which is exactly what a rebuild test needs. Homebrew in `/opt/homebrew` is shared between users, though, so for a true from-scratch test, use a VM.

To tear down in place instead, work through the list below, then follow "Setting up a new machine" from step 1.

### Back up first

These are hard or impossible to recreate:

- **GPG private key:** `gpg --export-secret-keys --armor C8682424579A5DC5 > key.asc`. Store it somewhere safe outside `~`. **Never delete `~/.gnupg` without this.**
- **Shell history:** `~/.zsh_history`.
- **Anything you customised by hand that the repo doesn't track,** e.g. `~/.zprofile` (it loads the private employer config) and `~/.claude` (Claude Code settings and memory).

### What setup creates, and how to remove it

Quit iTerm2 first and run these from Terminal.app.

| Created by | What | Remove with |
| --- | --- | --- |
| `setup/create_links` | Symlinks `~/.zshrc`, `~/.gitconfig`, `~/.gitignore`, `~/.config/starship.toml` | `rm ~/.zshrc ~/.gitconfig ~/.gitignore ~/.config/starship.toml` |
| `setup/configure` | A `pinentry-program` line in `~/.gnupg/gpg-agent.conf` | Delete that line (or the file, if it's the only line) |
| `setup/python_install` | Python versions in `~/.pyenv` | `rm -rf ~/.pyenv` |
| `setup/iterm2` | `DynamicProfiles/dotfiles.json` symlink, default-profile setting | `defaults delete com.googlecode.iterm2` and `rm -rf ~/Library/Application\ Support/iTerm2` (erases **all** iTerm2 settings) |
| `setup/brew_install` | Every formula, cask, font and tap in `Brewfile` | Uninstall Homebrew entirely with its official uninstall script (see <https://docs.brew.sh/FAQ>). This also removes everything it installed. |
| Claude Code installer | `~/.local/bin/claude`, `~/.local/share/claude` | `rm -rf ~/.local/bin/claude ~/.local/share/claude` (keep `~/.claude` unless you backed it up) |

### State the tools create as you use them

Not strictly part of setup, but delete it for a clean test:

| Tool | Path |
| --- | --- |
| zsh completion cache | `~/.zcompdump*` |
| Cached tool init scripts (`.zshrc`) | `~/.cache/zsh-init` |
| Editor settings backups (`setup/editors`) | `~/.cache/dotfiles/editor-backups` |
| zoxide (directory history) | `~/Library/Application Support/zoxide` |
| direnv (allowed `.envrc` files) | `~/.local/share/direnv` |
| starship | `~/.cache/starship` |
| bun (global packages) | `~/.bun` |
| poetry | `~/Library/Caches/pypoetry` |
| Rancher Desktop | `~/.rd`, plus the app's own reset (Troubleshooting → Factory Reset) |

### Leftovers from older versions of this repo

Only present if this machine was set up before the current install rules:

| What | Path |
| --- | --- |
| pipx and pipx-installed poetry | `~/.local/pipx`, `~/.local/bin/poetry` |
| curl-installed bun | `~/.bun` |
| nvm / Node | `~/.nvm` |
| `~/.aliases` symlink (`.zshrc` now sources `.aliases` from the repo) | `~/.aliases` |
| PATH line pipx added to `~/.zprofile` | The `# Created by pipx` line and the `export PATH=...` after it |
