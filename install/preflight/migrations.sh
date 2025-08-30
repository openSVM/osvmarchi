#!/bin/bash

OSVMARCHI_MIGRATIONS_STATE_PATH=~/.local/state/osvmarchi/migrations
mkdir -p $OSVMARCHI_MIGRATIONS_STATE_PATH

for file in ~/.local/share/osvmarchi/migrations/*.sh; do
  touch "$OSVMARCHI_MIGRATIONS_STATE_PATH/$(basename "$file")"
done
