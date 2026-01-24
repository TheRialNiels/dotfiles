# Set identification from install inputs
if [[ -n "${TRND_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$TRND_USER_NAME"
fi

if [[ -n "${TRND_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$TRND_USER_EMAIL"
fi
