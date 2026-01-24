TRND_MIGRATIONS_STATE_PATH=~/.local/state/trnd/migrations
mkdir -p $TRND_MIGRATIONS_STATE_PATH

for file in ~/.local/share/trnd/migrations/*.sh; do
  touch "$TRND_MIGRATIONS_STATE_PATH/$(basename "$file")"
done
