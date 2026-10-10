#!/bin/bash
# User services that need their unit files in place first.
set -euo pipefail

systemctl --user daemon-reload
systemctl --user enable --now wayvnc.service
