# Omarchy dotfiles

My Omarchy customizations, managed with [chezmoi](https://chezmoi.io).

## New machine

1. Install Omarchy from the ISO.
2. Run:
   ```
   omarchy pkg add chezmoi
   chezmoi init --apply --force CillianMyles/omarchy-dotfiles
   ```
   `run_onchange_before_10-setup-system.sh.tmpl` runs first (packages, SSH,
   firewall, Tailscale, keyboard layout, headless lid/Wake-on-LAN), then the
   config files are written, then `run_onchange_after_20-enable-user-services.sh`
   starts user services (wayvnc).

System files that live outside `$HOME` are kept in `system/` and installed by
the setup script.

chezmoi asks two questions on the first `init`, remembered per machine in
`~/.config/chezmoi/chezmoi.toml`:

- **Headless server**: wayvnc (Tailscale only), lid stays awake on AC or
  with an external display, no screensaver. Answer yes for frankenbook.
- **Reverse mouse wheel like macOS**: trackpads are always reversed.

Change answers later with `chezmoi init --prompt`, then `chezmoi apply`.

Detected automatically: the software-cursor fix (only with the nouveau
driver) and the Apple keyboard fn-key fix (only on Apple hardware).

## Day to day

- Changed a tracked file: `chezmoi re-add && chezmoi cd && git commit -am "..." && git push`
  - `re-add` skips templates (`*.tmpl`: `input.lua`, `looknfeel.lua`,
    `shell.json`). For those, run `chezmoi merge <path>` or edit with
    `chezmoi edit <path>` instead.
- Track a new file: `chezmoi add <path>`
- Made a system change (package, service, firewall): add it to
  `run_onchange_before_10-setup-system.sh.tmpl`
- Pull changes onto another machine: `chezmoi update`

Only files that differ from Omarchy's defaults are tracked, so Omarchy
updates still apply to everything else.
