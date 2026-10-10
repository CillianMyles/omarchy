# Omarchy dotfiles

My Omarchy customizations, managed with [chezmoi](https://chezmoi.io).

## New machine

1. Install Omarchy from the ISO.
2. Run:
   ```
   omarchy pkg add chezmoi
   chezmoi init --apply --force <this-repo-url>
   ```
   `run_onchange_before_10-setup-system.sh` runs first (packages, SSH,
   firewall, Tailscale, keyboard layout), then the config files are written.

## Day to day

- Changed a tracked file: `chezmoi re-add && chezmoi cd && git commit -am "..." && git push`
- Track a new file: `chezmoi add <path>`
- Made a system change (package, service, firewall): add it to
  `run_onchange_before_10-setup-system.sh`
- Pull changes onto another machine: `chezmoi update`

Only files that differ from Omarchy's defaults are tracked, so Omarchy
updates still apply to everything else.
