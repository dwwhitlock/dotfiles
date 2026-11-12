# Shell hotkeys

Hotkeys and shortcuts for the zsh setup in [`.zshrc`](.zshrc).

> **Keep in sync:** when you add or change a `bindkey`, `setopt`, plugin or tool
> init in `.zshrc`, update this file in the same commit. To check what is
> actually bound in a live shell, run `bindkey -M emacs` (or `bindkey '^R'` for
> one key).

**Notation:** `^X` = Ctrl-X. `M-x` = Option-x. Pressing `Esc` and then the key
also works.

The line editor is in **emacs mode** (`bindkey -e`), so these are emacs-style
keys, not vi.

## Terminals

The shortcuts below are the same in every terminal, as long as the terminal
passes the keys through to the shell. Two settings make that work: **Option
sends Esc+** (otherwise Option types characters like `ç` and `≥`, and none of
the `M-` keys work), and a **Nerd Font** for starship's icons.

| Terminal | Option as Esc+ and font set by | Known catch |
| --- | --- | --- |
| iTerm2 | `setup/iterm2` (`iterm2/dotfiles.json`) | Only **Left** Option sends Esc+; Right Option still types special characters |
| VS Code | `setup/editors` (`editors/vscode.json`) | None known |
| Zed | `setup/editors` (`editors/zed.json`) | None known |
| PyCharm | `setup/editors` (`editors/pycharm.json`) | **Override IDE shortcuts** (Settings → Tools → Terminal) must stay on, or PyCharm takes keys like `^R` and `^T` |

**Quick test in a new terminal:** press `M-.` (inserts the previous command's
last argument), `^R` (fzf history search) and `^T` (fzf file picker). If one
does nothing, or types a symbol:

1. Run `setup/editors` (or check the iTerm2 profile is the default) to confirm
   the settings are applied.
2. If they are, the terminal is keeping that key for itself. Look for the
   shortcut in that app's keymap and unbind it, or press `Esc` then the key
   instead of `M-`.

## Search and history

| Key | Action | Source |
| --- | --- | --- |
| `^R` | Fuzzy-search history (fzf). `^R` again toggles sort order | fzf |
| `↑` / `↓` | Step through commands that start with what you've already typed | `.zshrc` |
| `M-.` | Insert the last argument of the previous command (repeat to go further back) | zsh default |
| Leading space | A command typed with a leading space is not saved to history (`HIST_IGNORE_SPACE`) | `.zshrc` |

History is 100,000 entries, shared live across all open shells (`SHARE_HISTORY`),
with duplicates dropped.

## Files and directories

| Key / command | Action | Source |
| --- | --- | --- |
| `^T` | Fuzzy-pick files and paste their paths at the cursor | fzf |
| `M-c` | Fuzzy-pick a subdirectory and `cd` into it | fzf |
| `**<Tab>` | fzf completion for the word before it, e.g. `vim src/**<Tab>`, `kill **<Tab>`, `ssh **<Tab>` | fzf |
| `z <fragment>` | Jump to a frequently used directory (`z dot` → `~/code/dotfiles`) | zoxide |
| `zi <fragment>` | Same, but pick interactively with fzf | zoxide |
| `<dir>` alone | Typing a directory name `cd`s into it (`AUTO_CD`), e.g. `..` | `.zshrc` |
| `cd -<Tab>` | Pick from the directory stack; every `cd` is pushed (`AUTO_PUSHD`) | `.zshrc` |
| `dirs -v` | List the directory stack; `cd -2` jumps to entry 2 | `.zshrc` |

## Completion

| Key | Action | Source |
| --- | --- | --- |
| `Tab` | Complete. A second `Tab` opens a menu you can move through with arrow keys | `.zshrc` (`menu select`) |
| — | Matching is case-insensitive: `doc<Tab>` matches `Documents` | `.zshrc` |

## Autosuggestions

The rest of a matching history command shows in grey as you type.

| Key | Action | Source |
| --- | --- | --- |
| `→` or `^E` | Accept the whole suggestion | zsh-autosuggestions |
| `M-f` | Accept the suggestion one word at a time | zsh-autosuggestions |

Syntax highlighting colours the command red while it isn't a valid command, and
green once it is (zsh-syntax-highlighting).

## Editing the line

| Key | Action | Source |
| --- | --- | --- |
| `^A` / `^E` | Start / end of line | zsh default |
| `M-b` / `M-f` | Back / forward one word | zsh default |
| `^W` | Delete the word before the cursor. Stops at `/`, so it removes one path segment | `.zshrc` (`WORDCHARS`) |
| `M-d` | Delete the word after the cursor | zsh default |
| `^U` | Delete the whole line | zsh default |
| `^K` | Delete from the cursor to the end of the line | zsh default |
| `^Y` | Paste the last deleted text | zsh default |
| `^_` | Undo | zsh default |
| `M-u` / `M-l` | Uppercase / lowercase the next word | zsh default |
| `^X^E` | Open the current command in `$EDITOR` (nvim); save and quit to run it | `.zshrc` |
| `M-q` | Park the current line, run another command, then get the parked line back. (`^Q` is taken by terminal flow control.) | zsh default |
| `M-h` | Show help for the command under the cursor | zsh default |
| `^L` | Clear the screen | zsh default |
| `^G` | Cancel (e.g. leave a search) | zsh default |

## Typo correction

`setopt CORRECT` offers a fix when a command name looks mistyped:

```
zsh: correct 'gti' to 'git' [nyae]?
```

`y` = run the fix, `n` = run what you typed, `a` = abort, `e` = edit the line.
