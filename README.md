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

## Day to day

- Changed a tracked file: `chezmoi re-add && chezmoi cd && git commit -am "..." && git push`
- Track a new file: `chezmoi add <path>`
- Made a system change (package, service, firewall): add it to
  `run_onchange_before_10-setup-system.sh.tmpl`
- Pull changes onto another machine: `chezmoi update`

Only files that differ from Omarchy's defaults are tracked, so Omarchy
updates still apply to everything else.
