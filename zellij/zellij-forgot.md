# Zellij & Neovim Command Reference

## Zellij Keybindings (Ctrl+a prefix, tmux-style)

### Direct (no prefix needed)
| Keys | Action |
|------|--------|
| `Ctrl+h` | Move focus left |
| `Ctrl+j` | Move focus down |
| `Ctrl+k` | Move focus up |
| `Ctrl+l` | Move focus right |
| `Ctrl+r` | Enter resize mode (direct) |

### Command Mode (Ctrl+a, then key)
| Keys | Action |
|------|--------|
| `Ctrl+a` | Enter command mode |
| `Ctrl+a, Ctrl+a` | Exit command mode (double-tap) |
| `Esc` | Exit command mode |

### Pane Management (Ctrl+a, then...)
| Key | Action |
|-----|--------|
| `-` | Split pane down |
| `\` or `\|` | Split pane right |
| `s` | New stacked pane |
| `x` | Close focused pane |
| `z` | Toggle fullscreen |
| `f` | Toggle floating panes |
| `e` | Toggle embed/floating |
| `i` | Toggle pane pinned |
| `h/j/k/l` | Navigate panes |

### Tab Management (Ctrl+a, then...)
| Key | Action |
|-----|--------|
| `c` | New tab |
| `n` | Next tab |
| `p` | Previous tab |
| `1-5` | Go to tab 1-5 |
| `,` | Rename tab |
| `t` | Enter tab mode |

### Layout Switching (Ctrl+a, then...)
| Key | Action |
|-----|--------|
| `[` or `{` | Previous swap layout |
| `]` or `}` | Next swap layout |

Available layouts: `coding` (65/35), `wide` (80/20), `split` (horizontal), `focus` (editor only)

### Floating Tools (Ctrl+a, then...)
| Key | Action |
|-----|--------|
| `g` | Lazygit (floating) |
| `y` | Yazi file manager (floating) |
| `b` | Bottom system monitor (floating) |
| `q` | Lazysql database (floating) |

### Plugins (Ctrl+a, then...)
| Key | Action |
|-----|--------|
| `?` | Help (bat viewer, scrollable) |
| `F1` | Forgot plugin (searchable) |
| `m` | Monocle fuzzy finder |
| `;` | Harpoon quick nav |
| `r` | Room workspaces |
| `S` | Session manager |
| `P` | File picker |
| `C` | Configuration |

### Sub-modes (Ctrl+a, then...)
| Key | Mode |
|-----|------|
| `R` | Resize mode |
| `o` | Scroll mode |
| `t` | Tab mode |
| `M` | Move mode |
| `d` | Session mode |
| `L` | Locked mode |

### Resize Mode (Ctrl+r direct, or Ctrl+a R)
| Key | Action |
|-----|--------|
| `h/j/k/l` | Increase size in direction |
| `H/J/K/L` | Decrease size in direction |
| `+/=` | Increase overall |
| `-` | Decrease overall |

### Scroll Mode (Ctrl+a o)
| Key | Action |
|-----|--------|
| `j/k` | Scroll down/up |
| `d/u` | Half page down/up |
| `g/G` | Top/bottom |
| `/` | Search |
| `e` | Edit in $EDITOR |

### Session Mode (Ctrl+a d)
| Key | Action |
|-----|--------|
| `d` | Detach (keep running) |
| `q` | Quit (kill session) |

---

## Neovim Keybindings (Leader = Space)

### General
| Keys | Action |
|------|--------|
| `jk` or `kj` | Exit insert mode |
| `Space w` | Save file |
| `Space q` | Quit |
| `Space wq` | Save and quit |
| `x` | Delete char (no register) |
| `Space nh` | Clear search highlights |

### Buffers
| Keys / Command | Action |
|----------------|--------|
| `Shift+l` | Next buffer |
| `Shift+h` | Previous buffer |
| `:bd` | Delete/kill buffer |
| `:bd!` | Force kill buffer (unsaved) |
| `:bw` | Wipe buffer (fully remove) |
| `:%bd` | Delete all buffers |
| `:%bd\|e#` | Delete all except current |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:b#` | Alternate/last buffer |
| `:b <name>` | Go to buffer by name |
| `:b <num>` | Go to buffer by number |
| `:ls` | List all buffers |
| `:buffers` | List all buffers |
| `:enew` | New empty buffer (replaces current) |
| `:new` | New buffer in horizontal split |
| `:vnew` | New buffer in vertical split |

### Files & Editing
| Command | Action |
|---------|--------|
| `:e <file>` | Edit/open file |
| `:e!` | Revert to saved |
| `:w` | Save |
| `:w <file>` | Save as |
| `:wa` | Save all |
| `:q` | Quit |
| `:q!` | Quit without saving |
| `:qa` | Quit all |
| `:qa!` | Quit all without saving |
| `:wq` | Save and quit |
| `:x` | Save and quit (if changed) |
| `ZZ` | Save and quit |
| `ZQ` | Quit without saving |
| `:sav <file>` | Save as and switch |
| `:r <file>` | Insert file contents |
| `:r !<cmd>` | Insert command output |

### Windows (Splits)
| Keys / Command | Action |
|----------------|--------|
| `Space sv` | Split vertical |
| `Space sh` | Split horizontal |
| `Space se` | Equalize splits |
| `Space sx` | Close split |
| `:sp` | Horizontal split |
| `:vsp` | Vertical split |
| `:sp <file>` | Split and open file |
| `:vsp <file>` | Vsplit and open file |
| `Ctrl+w w` | Cycle windows |
| `Ctrl+w h/j/k/l` | Move to window |
| `Ctrl+w H/J/K/L` | Move window position |
| `Ctrl+w =` | Equalize windows |
| `Ctrl+w _` | Maximize height |
| `Ctrl+w \|` | Maximize width |
| `Ctrl+w o` | Close all other windows |
| `:only` | Close all other windows |
| `Ctrl+w q` | Close window |
| `Ctrl+w r` | Rotate windows |
| `Ctrl+w T` | Move window to new tab |

### Navigation
| Keys | Action |
|------|--------|
| `Ctrl+d` | Half page down (centered) |
| `Ctrl+u` | Half page up (centered) |
| `Shift+l` | Next buffer |
| `Shift+h` | Previous buffer |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `[q` | Previous quickfix item |
| `]q` | Next quickfix item |
| `[x` | Previous git conflict |
| `]x` | Next git conflict |

### Windows & Splits
| Keys | Action |
|------|--------|
| `Space sv` | Split vertical |
| `Space sh` | Split horizontal |
| `Space se` | Equalize splits |
| `Space sx` | Close split |
| `Ctrl+Up/Down` | Resize height |
| `Ctrl+Left/Right` | Resize width |

### Tabs
| Keys | Action |
|------|--------|
| `Space to` | New tab |
| `Space tx` | Close tab |
| `Space tn` | Next tab |
| `Space tp` | Previous tab |

### File Explorer (Neo-tree)
| Keys | Action |
|------|--------|
| `Space e` | Toggle file explorer |
| `Space ef` | Focus file explorer |
| `Space eg` | Git status |
| `Space eb` | Buffer explorer |

**In Neo-tree:**
| Key | Action |
|-----|--------|
| `Enter` | Open file |
| `Backspace` | Navigate up (parent dir) |
| `.` | Set as root |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `m` | Move |
| `y` | Copy to clipboard |
| `x` | Cut |
| `p` | Paste |
| `P` | Toggle preview |
| `l` | Focus preview |
| `S` | Open in split |
| `s` | Open in vsplit |
| `t` | Open in new tab |
| `C` | Close node |
| `z` | Close all nodes |
| `H` | Toggle hidden |
| `/` | Fuzzy finder |
| `R` | Refresh |
| `<` / `>` | Prev/next source |
| `i` | Show file details |
| `[g` / `]g` | Prev/next git modified |
| `?` | Help |

**Neo-tree Order By (press `o` then...):**
| Key | Action |
|-----|--------|
| `oc` | Order by created |
| `od` | Order by diagnostics |
| `og` | Order by git status |
| `om` | Order by modified |
| `on` | Order by name |
| `os` | Order by size |
| `ot` | Order by type |

**Neo-tree Git Status View:**
| Key | Action |
|-----|--------|
| `A` | Git add all |
| `ga` | Git add file |
| `gu` | Git unstage file |
| `gr` | Git revert file |
| `gc` | Git commit |
| `gp` | Git push |
| `gg` | Git commit and push |

### Oil (File Explorer)
| Keys | Action |
|------|--------|
| `Space -` | Open Oil in parent directory |

**In Oil (edit filesystem like a buffer):**
| Action | How |
|--------|-----|
| New file | Type filename on new line, `:w` |
| New directory | Type `dirname/` (trailing slash), `:w` |
| Delete | Delete the line, `:w` |
| Rename | Edit the filename, `:w` |

| Key | Action |
|-----|--------|
| `Enter` | Select (open file/enter dir) |
| `Ctrl+l` | Drill into nested dirs (3 levels) |
| `Backspace` | Go to parent directory |
| `Ctrl+v` | Open in vertical split |
| `Ctrl+s` | Open in horizontal split |
| `Ctrl+t` | Open in new tab |
| `Ctrl+p` | Preview |
| `Ctrl+c` | Close Oil |
| `Ctrl+r` | Refresh |
| `_` | Open cwd |
| `` ` `` | cd to directory |
| `~` | tcd to directory |
| `gs` | Change sort |
| `gx` | Open external |
| `g.` | Toggle hidden files |
| `g?` | Show help |

### Telescope (Fuzzy Finding)
| Keys | Action |
|------|--------|
| `Space ff` | Find files |
| `Space fr` | Recent files |
| `Space fs` | Live grep (search text) |
| `Space fc` | Search word under cursor |
| `Space ft` | Find TODOs |
| `Space fp` | Find projects |
| `Space fb` | Find buffers |
| `Space fh` | Find help |
| `Space fk` | Find keymaps |
| `Space fm` | Find marks |

**In Telescope:**
| Key | Action |
|-----|--------|
| `Ctrl+j/k` | Navigate results |
| `Ctrl+q` | Send to quickfix |
| `Ctrl+t` | Open in Trouble |

### LSP (Code Intelligence)
| Keys | Action |
|------|--------|
| `gd` | Go to definition (Telescope) |
| `gD` | Go to definition (direct) |
| `gR` | Show references |
| `gi` | Show implementations |
| `gt` | Show type definitions |
| `K` | Hover documentation |
| `Space ca` | Code actions |
| `Space rn` | Rename symbol |
| `Space d` | Line diagnostics |
| `Space D` | Buffer diagnostics |
| `Space rs` | Restart LSP |

### Formatting & Linting
| Keys | Action |
|------|--------|
| `Space mp` | Format file/range (conform) |
| `Space ll` | Trigger linting |
| (auto) | Format on save |
| (auto) | Lint on save/insert leave |

### Git
| Keys | Action |
|------|--------|
| `Space lg` | LazyGit |
| `Space gs` | Neogit status |
| `Space gc` | Neogit commit |
| `Space gp` | Neogit pull |
| `Space gP` | Neogit push |
| `Space gd` | DiffView open |
| `Space gx` | DiffView close |
| `Space gbt` | Toggle git blame |
| `Space gbo` | Open commit URL |
| `Space gbc` | Copy SHA |

**Git Conflicts:**
| Keys | Action |
|------|--------|
| `Space gco` | Choose ours |
| `Space gct` | Choose theirs |
| `Space gcb` | Choose both |
| `Space gc0` | Choose none |

### Debugging (DAP)
| Keys | Action |
|------|--------|
| `Space dt` | Toggle breakpoint |
| `Space dc` | Continue |
| `Space di` | Step into |
| `Space do` | Step over |
| `Space du` | Step out / Toggle UI |
| `Space db` | Step back |
| `Space dC` | Run to cursor |
| `Space dd` | Disconnect |
| `Space dp` | Pause |
| `Space dr` | Toggle REPL |
| `Space ds` | Start |
| `Space dq` | Terminate |

### Testing (Neotest)
| Keys | Action |
|------|--------|
| `Space tt` | Run nearest test |
| `Space tf` | Run file tests |
| `Space td` | Debug nearest test |
| `Space ts` | Toggle test summary |
| `Space to` | Open test output |

### Trouble (Diagnostics)
| Keys | Action |
|------|--------|
| `Space xx` | Toggle diagnostics |
| `Space xX` | Buffer diagnostics |
| `Space xs` | Symbols |
| `Space xq` | Quickfix list |

### Spectre (Search & Replace)
| Keys | Action |
|------|--------|
| `Space S` | Toggle Spectre |
| `Space sw` | Search current word |
| `Space sp` | Search in file |

**In Spectre:**
| Key | Action |
|-----|--------|
| `dd` | Toggle line |
| `Enter` | Open file |
| `Space R` | Replace all |
| `Space rc` | Replace current |

### Harpoon (Quick File Nav)
| Keys | Action |
|------|--------|
| `Space ha` | Add to harpoon |
| `Space hh` | Toggle harpoon menu |
| `Space h1-4` | Jump to file 1-4 |
| `Ctrl+Shift+P` | Previous harpoon |
| `Ctrl+Shift+N` | Next harpoon |

### Terminal (ToggleTerm)
| Keys | Action |
|------|--------|
| `Ctrl+\` | Toggle terminal |
| `Space tf` | Float terminal |
| `Space th` | Horizontal terminal |
| `Space tv` | Vertical terminal |
| `Space gt` | Go tests |
| `Space rt` | Rust tests |

### Folding (UFO)
| Keys | Action |
|------|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zr` | Fold less |
| `zm` | Fold more |
| `zp` | Peek fold |

### Code Outline (Aerial)
| Keys | Action |
|------|--------|
| `Space a` | Toggle Aerial |

### Comments (Comment.nvim)
| Keys | Action |
|------|--------|
| `Space /` | Toggle comment |
| `gc` | Comment (motion) |
| `gcc` | Comment line |
| `gcO` | Comment above |
| `gco` | Comment below |
| `gcA` | Comment end of line |
| `gb` | Block comment (motion) |
| `gbc` | Block comment line |

### Gitsigns (Hunk Navigation)
| Keys | Action |
|------|--------|
| `]h` | Next hunk |
| `[h` | Previous hunk |
| `Space hs` | Stage hunk |
| `Space hr` | Reset hunk |
| `Space hS` | Stage buffer |
| `Space hR` | Reset buffer |
| `Space hu` | Undo stage hunk |
| `Space hp` | Preview hunk |
| `Space hb` | Blame line |
| `Space hB` | Blame buffer |
| `Space hd` | Diff this |
| `Space hD` | Diff this ~ |
| `ih` | (text obj) inner hunk |

### Surround
| Keys | Action |
|------|--------|
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |

### Session
| Keys | Action |
|------|--------|
| `Space qs` | Restore session |
| `Space ql` | Restore last session |
| `Space qd` | Don't save session |

### Database (vim-dadbod)
| Keys | Action |
|------|--------|
| `Space db` | Toggle Database UI |
| `Space dB` | Add DB connection |
| `Space df` | Find DB buffer |

**In DBUI Drawer:**
| Key | Action |
|-----|--------|
| `Enter` | Execute query / expand |
| `o` | Open/toggle node |
| `R` | Refresh |
| `d` | Delete saved query |
| `S` | Save query |
| `r` | Rename |
| `A` | Add connection |
| `H` | Toggle help |
| `q` | Close DBUI |

**In SQL Buffer:**
| Key | Action |
|-----|--------|
| `<C-e>` | Execute query (visual or line) |
| `:DB` | Run SQL command |
| (completion) | Auto-complete tables/columns |

**Table Helpers (on table node):**
- `Count` - SELECT COUNT(*)
- `Columns` - Show column info
- `Sample` - SELECT * LIMIT 100

### Go-Specific (go.nvim / gopher.nvim)
| Keys | Action |
|------|--------|
| `Space gsj` | Add struct tags (json) |
| `Space gsy` | Add struct tags (yaml) |
| `Space gst` | Add struct tags (toml) |
| `Space gsr` | Remove struct tags |
| `Space gta` | Run all tests |
| `Space gts` | Run test suite |
| `Space gtf` | Run file tests |
| `Space gtc` | Run test coverage |
| `Space gfs` | Fill struct |
| `Space gif` | If err snippet |
| `Space gie` | If err return err |
| `Space gr` | Go run |
| `Space gb` | Go build |

### Rust-Specific
| Keys | Action |
|------|--------|
| `Space rr` | Runnables |
| `Space rt` | Testables |
| `Space rm` | Expand macro |
| `Space rc` | Open Cargo.toml |
| `Space rp` | Parent module |
| `Space rd` | Debuggables |
| `Space rh` | Hover actions |
| `Space rj` | Join lines |
| `Space ra` | Code action |
| `Space re` | Explain error |
| `Space rw` | Reload workspace |
| `Space rs` | Structural search |
| `Space rg` | Crate graph |

### Crates.nvim (Cargo.toml)
| Keys | Action |
|------|--------|
| `Space ct` | Toggle crates |
| `Space cr` | Reload crates |
| `Space cv` | Versions popup |
| `Space cf` | Features popup |
| `Space cd` | Dependencies popup |
| `Space cu` | Update crate |
| `Space ca` | Update all crates |
| `Space cU` | Upgrade crate |
| `Space cA` | Upgrade all crates |
| `Space cH` | Open homepage |
| `Space cR` | Open repository |
| `Space cD` | Open documentation |
| `Space cC` | Open crates.io |

### Line Operations
| Keys | Action |
|------|--------|
| `Space ld` | Duplicate line down |
| `Space lu` | Duplicate line up |
| `Space lo` | Insert line below |
| `Space lO` | Insert line above |
| `Space lx` | Delete line |
| `Space lc` | Clear line |
| `J` | Join lines (centered) |
| `Space J` | Join paragraph |

### Text Manipulation
| Keys | Action |
|------|--------|
| `Space +` | Increment number |
| `Space -` | Decrement number |
| `Space sa` | Select all |
| `Space p` | Paste with indent |
| `Space sr` | Search/replace word |
| `Ctrl+t` | Transpose chars |

### Case Toggle
| Keys | Action |
|------|--------|
| `Space tc` | Toggle case |
| `Space tu` | Uppercase |
| `Space tl` | Lowercase |

### Visual Mode
| Keys | Action |
|------|--------|
| `J` | Move selection down |
| `K` | Move selection up |
| `<` / `>` | Indent (stay in mode) |
| `p` | Paste (no overwrite) |

### Completion (nvim-cmp)
| Keys | Action |
|------|--------|
| `Ctrl+Space` | Trigger completion |
| `Ctrl+j/n` | Next item |
| `Ctrl+k/p` | Previous item |
| `Ctrl+b` | Scroll docs up |
| `Ctrl+f` | Scroll docs down |
| `Ctrl+e` | Close completion |
| `Enter` | Confirm selection |
| `Tab` | Next item / expand snippet |
| `Shift+Tab` | Previous item |

### Autopairs
| Keys | Action |
|------|--------|
| `Alt+e` | Fast wrap (surround next) |

### Snippets (LuaSnip)
| Keys | Action |
|------|--------|
| `Ctrl+k` | Expand snippet |
| `Ctrl+l` | Jump to next placeholder |
| `Ctrl+j` | Jump to previous placeholder |
| `Ctrl+e` | Change choice (in choice node) |

### Multi-cursor (vim-visual-multi)
| Keys | Action |
|------|--------|
| `Ctrl+n` | Select word / next occurrence |
| `Ctrl+x` | Skip current occurrence |
| `Ctrl+p` | Remove current / prev occurrence |
| `\\A` | Select all occurrences |
| `\\/` | Regex search |
| `\\c` | Add cursor at position |
| `n/N` | Get next/prev occurrence |
| `[/]` | Select next/prev cursor |
| `q` | Skip and get next |
| `Q` | Remove region under cursor |
| `Tab` | Switch between extend/cursor mode |

### Mini.move (Move Lines/Selections)
| Keys | Action |
|------|--------|
| `Alt+h` | Move line/selection left |
| `Alt+j` | Move line/selection down |
| `Alt+k` | Move line/selection up |
| `Alt+l` | Move line/selection right |

### Mini.splitjoin
| Keys | Action |
|------|--------|
| `gS` | Toggle split/join |

### Mini.operators
| Keys | Action |
|------|--------|
| `g=` | Evaluate (motion) |
| `gx` | Exchange (motion) |
| `gm` | Multiply/duplicate (motion) |
| `gr` | Replace with register (motion) |
| `gs` | Sort (motion) |

### Dial.nvim (Increment/Decrement)
| Keys | Action |
|------|--------|
| `Ctrl+a` | Increment |
| `Ctrl+x` | Decrement |
| `g Ctrl+a` | Increment (additive in visual) |
| `g Ctrl+x` | Decrement (additive in visual) |

Works on: numbers, dates, booleans, operators (++/--), hex colors

### Todo-comments Navigation
| Keys | Action |
|------|--------|
| `]t` | Next todo comment |
| `[t` | Previous todo comment |

### Which-Key
| Keys | Action |
|------|--------|
| `Space` (wait) | Show available keybindings |

---

## Standard Vim Commands

### Motions (Movement)
| Keys | Action |
|------|--------|
| `h/j/k/l` | Left/down/up/right |
| `w` | Next word start |
| `W` | Next WORD start |
| `b` | Previous word start |
| `B` | Previous WORD start |
| `e` | Next word end |
| `E` | Next WORD end |
| `ge` | Previous word end |
| `0` | Line start |
| `^` | First non-blank |
| `$` | Line end |
| `g_` | Last non-blank |
| `gg` | File start |
| `G` | File end |
| `{num}G` | Go to line |
| `{` / `}` | Paragraph up/down |
| `(` / `)` | Sentence up/down |
| `[[` / `]]` | Section up/down |
| `%` | Matching bracket |
| `f{char}` | Find char forward |
| `F{char}` | Find char backward |
| `t{char}` | Till char forward |
| `T{char}` | Till char backward |
| `;` | Repeat f/F/t/T |
| `,` | Repeat f/F/t/T reverse |
| `H` | Screen top |
| `M` | Screen middle |
| `L` | Screen bottom |
| `Ctrl+f` | Page down |
| `Ctrl+b` | Page up |
| `Ctrl+d` | Half page down |
| `Ctrl+u` | Half page up |
| `Ctrl+e` | Scroll down (cursor stays) |
| `Ctrl+y` | Scroll up (cursor stays) |
| `zz` | Center cursor line |
| `zt` | Cursor line to top |
| `zb` | Cursor line to bottom |
| `gj` / `gk` | Visual line down/up |

### Text Objects (use with d, c, y, v)
| Keys | Action |
|------|--------|
| `iw` / `aw` | inner/around word |
| `iW` / `aW` | inner/around WORD |
| `is` / `as` | inner/around sentence |
| `ip` / `ap` | inner/around paragraph |
| `i"` / `a"` | inner/around double quotes |
| `i'` / `a'` | inner/around single quotes |
| `` i` `` / `` a` `` | inner/around backticks |
| `i(` / `a(` | inner/around parentheses |
| `i[` / `a[` | inner/around brackets |
| `i{` / `a{` | inner/around braces |
| `i<` / `a<` | inner/around angle brackets |
| `it` / `at` | inner/around XML tag |
| `ib` / `ab` | inner/around block () |
| `iB` / `aB` | inner/around block {} |

### Operators
| Keys | Action |
|------|--------|
| `d` | Delete |
| `c` | Change (delete + insert) |
| `y` | Yank (copy) |
| `~` | Toggle case |
| `g~` | Toggle case (motion) |
| `gu` | Lowercase (motion) |
| `gU` | Uppercase (motion) |
| `>` | Indent right (motion) |
| `<` | Indent left (motion) |
| `=` | Auto-indent (motion) |
| `!` | Filter through command |

### Editing
| Keys | Action |
|------|--------|
| `i` | Insert before cursor |
| `I` | Insert at line start |
| `a` | Insert after cursor |
| `A` | Insert at line end |
| `o` | New line below |
| `O` | New line above |
| `s` | Substitute char |
| `S` | Substitute line |
| `r{char}` | Replace char |
| `R` | Replace mode |
| `x` | Delete char |
| `X` | Delete char before |
| `dd` | Delete line |
| `D` | Delete to line end |
| `cc` | Change line |
| `C` | Change to line end |
| `yy` | Yank line |
| `Y` | Yank to line end |
| `p` | Paste after |
| `P` | Paste before |
| `gp` | Paste after, cursor after |
| `gP` | Paste before, cursor after |
| `J` | Join lines |
| `gJ` | Join lines (no space) |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last change |
| `@:` | Repeat last ex command |

### Marks
| Keys | Action |
|------|--------|
| `m{a-z}` | Set local mark |
| `m{A-Z}` | Set global mark |
| `` `{mark} `` | Jump to mark (exact) |
| `'{mark}` | Jump to mark (line start) |
| `` `` `` | Previous position |
| `''` | Previous line |
| `` `. `` | Last change position |
| `` `^ `` | Last insert position |
| `` `[ `` / `` `] `` | Start/end of last yank/change |
| `` `< `` / `` `> `` | Start/end of last visual |
| `:marks` | List all marks |
| `:delmarks a` | Delete mark a |
| `:delmarks!` | Delete all lowercase marks |

### Registers
| Keys | Action |
|------|--------|
| `"{reg}y` | Yank to register |
| `"{reg}p` | Paste from register |
| `""` | Unnamed (default) |
| `"0` | Last yank |
| `"1-9` | Delete history |
| `"+` | System clipboard |
| `"*` | Primary selection |
| `"_` | Black hole (discard) |
| `"/` | Last search |
| `":` | Last command |
| `".` | Last inserted text |
| `"%` | Current filename |
| `"#` | Alternate filename |
| `"=` | Expression register |
| `:reg` | List all registers |

### Macros
| Keys | Action |
|------|--------|
| `q{a-z}` | Record macro to register |
| `q` | Stop recording |
| `@{a-z}` | Play macro |
| `@@` | Replay last macro |
| `{n}@{a-z}` | Play macro n times |
| `:reg {a}` | View macro contents |

### Search & Replace
| Keys | Action |
|------|--------|
| `/{pattern}` | Search forward |
| `?{pattern}` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor |
| `#` | Search word backward |
| `g*` / `g#` | Partial word search |
| `:noh` | Clear highlight |
| `:s/old/new/` | Replace first in line |
| `:s/old/new/g` | Replace all in line |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all (confirm) |
| `:'<,'>s/old/new/g` | Replace in selection |
| `&` | Repeat last substitute |
| `g&` | Repeat last substitute (all) |

**Search flags:** `g` = global, `c` = confirm, `i` = ignore case, `I` = case sensitive

### Visual Mode
| Keys | Action |
|------|--------|
| `v` | Character visual |
| `V` | Line visual |
| `Ctrl+v` | Block visual |
| `gv` | Reselect last visual |
| `o` | Move to other end |
| `O` | Move to other corner (block) |
| `I` | Insert at all lines (block) |
| `A` | Append to all lines (block) |
| `$` | Extend to line end (block) |

### Folds
| Keys | Action |
|------|--------|
| `zo` | Open fold |
| `zc` | Close fold |
| `za` | Toggle fold |
| `zO` | Open all nested |
| `zC` | Close all nested |
| `zA` | Toggle all nested |
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zr` | Reduce folding level |
| `zm` | Increase folding level |
| `zj` / `zk` | Next/prev fold |
| `[z` / `]z` | Fold start/end |

### Jumps & Changes
| Keys | Action |
|------|--------|
| `Ctrl+o` | Jump back |
| `Ctrl+i` | Jump forward |
| `g;` | Previous change |
| `g,` | Next change |
| `:jumps` | List jump history |
| `:changes` | List change history |

### Tags (LSP/ctags)
| Keys | Action |
|------|--------|
| `Ctrl+]` | Jump to tag/definition |
| `Ctrl+t` | Jump back from tag |
| `g]` | List all matching tags |
| `:tag {name}` | Jump to tag |
| `:ts {name}` | List matching tags |
| `:tn` / `:tp` | Next/prev tag |

### Quickfix & Location List
| Keys | Action |
|------|--------|
| `:copen` | Open quickfix |
| `:cclose` | Close quickfix |
| `:cn` / `:cp` | Next/prev quickfix |
| `:cc {n}` | Go to quickfix n |
| `:cnf` / `:cpf` | Next/prev quickfix file |
| `:lopen` | Open location list |
| `:lclose` | Close location list |
| `:ln` / `:lp` | Next/prev location |

### Spell Check
| Keys | Action |
|------|--------|
| `:set spell` | Enable spell check |
| `]s` / `[s` | Next/prev misspelling |
| `z=` | Suggest corrections |
| `zg` | Add word to dictionary |
| `zw` | Mark word as wrong |

---

## Shell Aliases

| Alias | Command |
|-------|---------|
| `zj` | Start zellij (smart theme) |
| `dev` | Start with dev layout |
| `zja` | Attach to session |
| `zjl` | List sessions |
| `zjk` | Kill session |
| `zjdark` | Switch to kanagawa |
| `zjlight` | Switch to catppuccin-latte |
| `zrust` | Zellij rust layout |
| `zgo` | Zellij go layout |
| `znode` | Zellij node layout |
| `zpy` | Zellij python layout |
| `zserver` | Zellij server layout |
| `zsplit` | Zellij split layout |

## Git Aliases
| Alias | Command |
|-------|---------|
| `gs` | git status |
| `ga` | git add |
| `gc` | git commit |
| `gp` | git push |
| `gl` | git pull |
| `gd` | git diff |
| `gb` | git branch |
| `gco` | git checkout |
| `glog` | git log --oneline --graph |

---

## Lazygit (TUI)
*Open with: `Ctrl+a g` (Zellij) or `Space lg` (Neovim)*

### Global
| Key | Action |
|-----|--------|
| `?` | Open keybindings menu |
| `x` | Open menu |
| `q` | Quit |
| `Q` | Quit without prompt |
| `Esc` | Cancel / go back |
| `@` | Open command log |
| `}` / `{` | Cycle diff views |
| `Ctrl+r` | Switch to recent repos |
| `+` | Next screen mode (normal/half/full) |
| `_` | Previous screen mode |
| `p` | Pull |
| `P` | Push |
| `z` | Undo (via reflog) |
| `Ctrl+z` | Redo (via reflog) |

### Files Panel (1)
| Key | Action |
|-----|--------|
| `Space` | Stage/unstage file |
| `a` | Stage all / unstage all |
| `c` | Commit |
| `C` | Commit with editor |
| `A` | Amend last commit |
| `d` | Discard changes |
| `D` | Discard all changes (menu) |
| `e` | Edit file |
| `o` | Open file in default app |
| `i` | Ignore file (.gitignore) |
| `r` | Refresh files |
| `s` | Stash all changes |
| `S` | Stash options |
| `Enter` | Stage lines / view file |
| `/` | Filter files |

### Branches Panel (2)
| Key | Action |
|-----|--------|
| `Space` | Checkout branch |
| `n` | New branch |
| `d` | Delete branch |
| `r` | Rebase onto |
| `R` | Rename branch |
| `M` | Merge into current |
| `f` | Fast-forward |
| `g` | View reset options |
| `c` | Checkout by name |
| `Enter` | View commits |
| `u` | Set/unset upstream |

### Commits Panel (3)
| Key | Action |
|-----|--------|
| `Enter` | View commit files |
| `Space` | Checkout commit |
| `c` | Copy commit (for cherry-pick) |
| `C` | Copy range |
| `v` | Paste (cherry-pick) |
| `d` | Delete commit |
| `e` | Edit commit |
| `r` | Reword commit |
| `s` | Squash down |
| `f` | Fixup commit |
| `p` | Pick commit (rebase) |
| `t` | Create tag |
| `g` | Reset to commit |
| `y` | Copy commit SHA |
| `o` | Open commit in browser |

### Stash Panel (4)
| Key | Action |
|-----|--------|
| `Space` | Apply stash |
| `g` | Pop stash |
| `d` | Drop stash |
| `n` | New branch from stash |
| `r` | Rename stash |

### Staging View (within file)
| Key | Action |
|-----|--------|
| `Space` | Stage/unstage line |
| `a` | Stage/unstage hunk |
| `A` | Stage/unstage all hunks |
| `d` | Discard line |
| `v` | Toggle visual select |
| `Tab` | Switch to other panel |
| `e` | Edit hunk in editor |
| `/` | Search |

### Navigation
| Key | Action |
|-----|--------|
| `1-5` | Switch to panel 1-5 |
| `Tab` | Next panel |
| `Shift+Tab` | Previous panel |
| `h/j/k/l` | Navigate |
| `H/L` | Scroll left/right |
| `<` / `>` | Scroll diff left/right |
| `[` / `]` | Previous/next hunk |
| `Ctrl+d/u` | Scroll down/up |
| `g` / `G` | Top / bottom |

---

## Lazysql (TUI)
*Open with: `Ctrl+a q` (Zellij floating)*

### Global
| Key | Action |
|-----|--------|
| `?` | Toggle help |
| `q` / `Ctrl+c` | Quit |
| `Ctrl+e` | Open SQL editor |
| `Ctrl+r` | Run query |
| `Ctrl+s` | Save query |
| `Ctrl+Space` | Toggle sidebar |

### Navigation
| Key | Action |
|-----|--------|
| `Tab` | Next panel |
| `Shift+Tab` | Previous panel |
| `h/j/k/l` | Navigate |
| `g` / `G` | Top / bottom |
| `Ctrl+d/u` | Page down/up |
| `Enter` | Select / expand |
| `Esc` | Back / cancel |

### Sidebar (Connections/Tables)
| Key | Action |
|-----|--------|
| `c` | New connection |
| `e` | Edit connection |
| `d` | Delete connection |
| `Enter` | Connect / expand |
| `r` | Refresh |
| `/` | Filter |

### Table View
| Key | Action |
|-----|--------|
| `Enter` | View table data |
| `d` | Describe table |
| `s` | Select * from table |
| `c` | Count rows |
| `i` | Show indexes |
| `f` | Show foreign keys |

### Results Pane
| Key | Action |
|-----|--------|
| `j/k` | Navigate rows |
| `h/l` | Navigate columns |
| `y` | Copy cell |
| `Y` | Copy row |
| `Enter` | Expand cell |
| `/` | Search |
| `n/N` | Next/prev match |

### SQL Editor
| Key | Action |
|-----|--------|
| `Ctrl+r` | Run query |
| `Ctrl+Space` | Autocomplete |
| `Ctrl+s` | Save query |
| `Ctrl+o` | Open saved query |
| `Ctrl+l` | Clear editor |
| `Ctrl+/` | Toggle comment |

---

## Yazi (File Manager TUI)
*Open with: `Ctrl+a y` (Zellij) or `y` (shell function, cd on exit)*

### Navigation
| Key | Action |
|-----|--------|
| `h` / `l` | Parent / enter directory |
| `j` / `k` | Down / up |
| `J` / `K` | Scroll preview down/up |
| `g` / `G` | First / last |
| `H` / `M` / `L` | Top / middle / bottom of list |
| `z` | Jump to directory (fzf) |
| `Z` | Jump to directory (zoxide) |
| `-` | Back to previous |
| `~` | Home directory |
| `` ` `` | Toggle hidden files |

### Selection
| Key | Action |
|-----|--------|
| `Space` | Toggle selection |
| `v` | Visual mode |
| `V` | Visual mode (inverse) |
| `Ctrl+a` | Select all |
| `Ctrl+r` | Select all (inverse) |
| `Esc` | Clear selection |

### File Operations
| Key | Action |
|-----|--------|
| `Enter` | Open file |
| `o` | Open with... |
| `y` | Copy (yank) |
| `x` | Cut |
| `p` | Paste |
| `P` | Paste (overwrite) |
| `d` | Move to trash |
| `D` | Permanently delete |
| `a` | Create file |
| `A` | Create directory |
| `r` | Rename |
| `c` | Copy path |
| `.` | Toggle hidden |

### Tabs
| Key | Action |
|-----|--------|
| `t` | New tab |
| `1-9` | Switch to tab |
| `[` / `]` | Previous / next tab |
| `{` / `}` | Swap tab left/right |

### Search/Filter
| Key | Action |
|-----|--------|
| `/` | Search |
| `n` / `N` | Next / previous match |
| `f` | Filter |
| `s` | Sort menu |

### Bulk Operations
| Key | Action |
|-----|--------|
| `:` | Shell command |
| `;` | Shell command (block) |
| `!` | Shell command (spawn) |
| `S` | Open shell here |

### View Modes
| Key | Action |
|-----|--------|
| `w` | Tasks manager |
| `Ctrl+p` | Preview toggle |
| `T` | Toggle tree mode |

---

## Bottom (System Monitor TUI)
*Open with: `Ctrl+a b` (Zellij floating)*

### Global
| Key | Action |
|-----|--------|
| `q` / `Esc` | Quit |
| `e` | Toggle process tree |
| `s` | Toggle sort menu |
| `h` / `?` | Help |
| `/` | Search processes |
| `Tab` | Next widget |
| `Shift+Tab` | Previous widget |

### Process Control
| Key | Action |
|-----|--------|
| `dd` | Kill process (SIGTERM) |
| `d3` | Kill process (SIGKILL) |
| `Enter` | Expand process |

### Navigation
| Key | Action |
|-----|--------|
| `j/k` | Down/up |
| `g/G` | Top/bottom |
| `Ctrl+d/u` | Page down/up |
| `h/l` | Left/right in graphs |

### Display
| Key | Action |
|-----|--------|
| `t` | Toggle CPU view |
| `m` | Toggle memory view |
| `n` | Toggle network view |
| `p` | Toggle process view |
| `c` | Sort by CPU |
| `r` | Sort by memory |
| `P` | Sort by PID |
| `N` | Sort by name |

## Modern CLI Tools
| Alias/Command | Description |
|---------------|-------------|
| `y` | Yazi file manager (cd on exit) |
| `j` | Just command runner |
| `cat` | bat (syntax highlighting) |
| `find` | fd (faster find) |
| `ls` | eza (icons) |
| `ll` | eza -la |
| `tree` | eza --tree |
| `top` | htop |
| `du` | dust (disk usage) |
| `ps` | procs (process viewer) |
| `bench` | hyperfine (benchmarks) |
| `watch` | watchexec (file watcher) |
| `nv` | neovim |
| `vim` | neovim |
| `cheat` | glow ~/ULTIMATE_NVIM_TMUX_CHEATSHEET.md |

## Atuin (Shell History)
| Keys | Action |
|------|--------|
| `Ctrl+r` | Search history |
| `Up/Down` | Navigate results |
| `Enter` | Execute command |
| `Tab` | Edit before execute |

## FZF Keybindings
| Keys | Action |
|------|--------|
| `Ctrl+t` | Find file |
| `Ctrl+r` | History search |
| `Alt+c` | Change directory |

## Navi (Interactive Cheatsheet)
| Keys | Action |
|------|--------|
| `Ctrl+g` | Open navi |

## Directory Shortcuts
| Alias | Path |
|-------|------|
| `proj` | ~/Projects |
| `desk` | ~/Desktop |
| `down` | ~/Downloads |
| `..` | cd .. |
| `...` | cd ../.. |
| `....` | cd ../../.. |

## Utility Functions
| Function | Description |
|----------|-------------|
| `mkcd <dir>` | Create directory and cd into it |
| `up <n>` | Go up n directories |
| `hg <pattern>` | Search history |
| `myip` | Show public IP |
| `path` | Show PATH (one per line) |
| `brewup` | Update all homebrew packages |
| `reload` | Source ~/.zshrc |
| `hex2wgpu <hex>` | Convert hex color to vec3f |

---

## Quick Reference

### Leader Combinations
```
Space e  → File explorer    Space f  → Find/Telescope
Space g  → Git              Space d  → Debug/Database
Space t  → Test/Toggle      Space r  → Rust/Run
Space x  → Trouble          Space h  → Harpoon/Hunks
Space l  → Line ops         Space s  → Split/Search
Space c  → Crates/Case      Space q  → Quit/Session
Space m  → Format           Space a  → Aerial outline
```

### Zellij Mode Indicators
- **NORMAL** (green) - Standard mode
- **PANE** (yellow) - Ctrl+Space
- **TAB** (cyan) - Ctrl+a t
- **RESIZE** (magenta) - Ctrl+r
- **SCROLL** (blue) - Ctrl+a o
- **SESSION** (red) - Ctrl+a d
- **LOCKED** (red blink) - Ctrl+a L

### Common Workflows

**Quick file navigation:**
```
Space ff → find file → Enter
Space e  → tree nav → Enter
Space ha → add to harpoon
Space h1 → jump to harpoon 1
```

**Git workflow:**
```
Ctrl+a g → lazygit (floating)
Space gs → Neogit status
Space lg → Lazygit in nvim
```

**Code navigation:**
```
gd → definition    gR → references
K  → hover docs    Space ca → actions
```

**Search & replace:**
```
Space fs → grep files
Space S  → Spectre (project-wide)
Space sr → replace word under cursor
```
