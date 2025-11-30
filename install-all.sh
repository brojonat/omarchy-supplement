#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Running installation scripts ==="
echo

# Find all *-install-*.sh scripts (e.g., 0010-install-stow.sh), sort numerically
# The sequence numbers (0010, 0020, etc.) allow for deterministic execution order
# with gaps for inserting new scripts without renumbering
for script in $(find "$SCRIPT_DIR" -maxdepth 1 -name "*-install-*.sh" | sort); do
	script_name="$(basename "$script")"
	echo ">>> Running $script_name..."

	if [ -x "$script" ]; then
		"$script"
	else
		echo "Warning: $script_name is not executable, skipping"
	fi

	echo "<<< Completed $script_name"
	echo
done

echo "=== All installations complete ==="
