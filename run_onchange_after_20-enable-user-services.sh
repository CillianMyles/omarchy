#!/bin/bash
# User services that need their unit files in place first.
set -euo pipefail

systemctl --user daemon-reload
systemctl --user enable wayvnc.service
# Starting needs the desktop session; over SSH it starts at the next login.
if systemctl --user is-active --quiet graphical-session.target; then
  systemctl --user restart wayvnc.service
fi
