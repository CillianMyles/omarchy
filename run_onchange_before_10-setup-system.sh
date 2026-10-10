#!/bin/bash
# System-level setup that dotfiles can't capture: extra packages, services,
# firewall and locale. Safe to re-run; chezmoi re-runs it whenever this file
# changes. Add a line here whenever you make a system change by hand.
set -euo pipefail

# Extra packages beyond Omarchy's defaults.
omarchy pkg add bitwarden bitwarden-cli t3code-bin

# Keyboard: US layout system-wide (TTY + boot password prompt).
if [[ $(localectl status) != *"X11 Layout: us"* ]]; then
  sudo localectl set-keymap us
  sudo localectl set-x11-keymap us
  if command -v limine-mkinitcpio >/dev/null; then
    sudo limine-mkinitcpio
  fi
fi

# SSH server, reachable through the firewall.
sudo systemctl enable --now sshd
sudo ufw allow 22/tcp comment SSH

# Tailscale (prompts for a browser login on first install).
if ! pacman -Q tailscale >/dev/null 2>&1; then
  omarchy install service tailscale
fi

# Voxtype dictation.
if ! pacman -Q voxtype-bin >/dev/null 2>&1; then
  omarchy-voxtype-install
fi
