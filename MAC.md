# macOS bootstrap

Setup notes for the `mac` branch. Files in `home/` mirror `$HOME`; symlink them
into place after cloning.

## Required dirs

```sh
mkdir -p ~/wallpapers ~/work ~/personal ~/.local/bin ~/.local/var/log
```

- `~/wallpapers/` — drop images here; the launchd agent picks one each hour.
- `~/work` / `~/personal` — project-pick.sh / pwork looks here for projects.

## Homebrew packages

```sh
brew install \
  aerospace \
  felixkratz/formulae/sketchybar \
  borders \
  wezterm \
  tmux \
  fzf bat ripgrep jq \
  neovim \
  task \
  nowplaying-cli

brew install --cask font-symbols-only-nerd-font

# Optional: paid font used in wezterm + sketchybar; falls back to JetBrains Mono / SF Mono otherwise.
# https://tosche.net/fonts/comic-code
```

## Symlink home/ files into $HOME

```sh
cd ~/dotfiles

ln -s "$PWD/home/.aerospace.toml" ~/.aerospace.toml
ln -s "$PWD/home/.wezterm.lua"    ~/.wezterm.lua
ln -s "$PWD/home/.zshrc"          ~/.zshrc
ln -s "$PWD/home/.config/sketchybar" ~/.config/sketchybar
ln -s "$PWD/home/.config/borders"    ~/.config/borders
ln -s "$PWD/home/.config/tmux"       ~/.config/tmux
ln -s "$PWD/home/.config/nvim"       ~/.config/nvim

# Local scripts
mkdir -p ~/.local/bin
for f in home/.local/bin/*.sh; do
    ln -s "$PWD/$f" "$HOME/.local/bin/$(basename "$f")"
done

# LaunchAgent for hourly wallpaper rotation
ln -s "$PWD/home/Library/LaunchAgents/com.melty.wallpaper-rotate.plist" \
      ~/Library/LaunchAgents/com.melty.wallpaper-rotate.plist
launchctl load ~/Library/LaunchAgents/com.melty.wallpaper-rotate.plist
```

> The LaunchAgent label and absolute paths inside the plist still say `melty`;
> if you're someone else, sed those before linking.

## Start services

```sh
brew services start felixkratz/formulae/sketchybar

# borders is invoked from aerospace's after-startup-command; just open AeroSpace
open -a AeroSpace
```

## Permissions

macOS will prompt for Accessibility (AeroSpace, JankyBorders, sketchybar) and
Automation (osascript controlling Finder/Brave/System Events). Grant them via
System Settings → Privacy & Security.

## What's where

- `~/.aerospace.toml` — tiling WM, app routing, smart-move/split bindings.
- `~/.config/sketchybar/` — floating cockpit bar (workspaces + cpu/mem/battery/volume/media/clock).
- `~/.config/borders/bordersrc` — yellow outline on focused window.
- `~/.local/bin/` — helper scripts (scratchpad, claude-space, pwork, …).
- `~/Library/LaunchAgents/com.melty.wallpaper-rotate.plist` — hourly wallpaper.

## Per-monitor gaps

`~/.aerospace.toml` configures `outer.top` per monitor — laptop tight (16),
externals 46. If your laptop's display name doesn't match `(?i)built-in`,
adjust the regex in the gaps section.
