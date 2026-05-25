# drewvanstone/homebrew-tap

Personal Homebrew tap for my open-source tools.

## Available formulas

| Name | Description |
|---|---|
| `snackpage` | Personal bookmark datastore with a keyboard-driven picker. See https://github.com/drewvanstone/snackpage |

## Install

```bash
brew tap drewvanstone/tap
brew install drewvanstone/tap/snackpage
brew services start snackpage
```

`brew services` handles the autostart launcher (LaunchAgent on macOS, systemd user unit on Linuxbrew). Daemon listens on `127.0.0.1:8765` by default; visit `http://127.0.0.1:8765/`.

## Development (local iteration)

Snackpage repo: `~/Code/personal/snackpage/`. Tap repo: this one.

When updating snackpage:

1. Tag a new release in the snackpage repo (e.g. `git tag v1.7.0`).
2. Build a tarball: `git -C ~/Code/personal/snackpage archive --format=tar.gz --prefix=snackpage-1.7.0/ -o /tmp/snackpage-1.7.0.tar.gz v1.7.0`
3. Update `Formula/snackpage.rb` with the new `version`, `url`, and `sha256` (`shasum -a 256 /tmp/snackpage-1.7.0.tar.gz`).
4. Reinstall: `brew uninstall snackpage && brew install drewvanstone/tap/snackpage`.

Or develop against the git HEAD: `brew install --HEAD drewvanstone/tap/snackpage`.

## Going public

When the snackpage repo lives on GitHub:
1. Push the tag to GitHub (`git push origin v1.7.0`).
2. Update `Formula/snackpage.rb`'s `url` from `file:///tmp/...` to `https://github.com/drewvanstone/snackpage/archive/v1.7.0.tar.gz`.
3. Push this tap repo to `github.com/drewvanstone/homebrew-tap`.
4. From any machine: `brew install drewvanstone/tap/snackpage`.
