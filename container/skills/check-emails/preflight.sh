#!/bin/bash
# Pre-flight check for /check-emails skill.
# Run this FIRST — it validates the environment and lists accounts in one shot.
set -euo pipefail

# 1. Main-channel check
if [ ! -d /workspace/project ]; then
  echo "ERROR: This command is available in your main chat only. Send /check-emails there."
  exit 1
fi

# 2. Check himalaya is installed
if ! command -v himalaya &>/dev/null; then
  echo "ERROR: himalaya is not installed in this container."
  exit 1
fi

# 3. Check config exists
if [ ! -f "$HOME/.config/himalaya/config.toml" ]; then
  echo "ERROR: No himalaya config found. Set up ~/.config/himalaya/config.toml on the host."
  exit 1
fi

# 4. List accounts
echo "OK"
echo "---ACCOUNTS---"
himalaya account list 2>&1
