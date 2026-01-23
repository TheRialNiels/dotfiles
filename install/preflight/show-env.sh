# Show installation environment variables
gum log --level info "Installation Environment:"

env | grep -E "^(TRND_CHROOT_INSTALL|TRND_ONLINE_INSTALL|TRND_USER_NAME|TRND_USER_EMAIL|USER|HOME|TRND_REPO|TRND_REF|TRND_PATH)=" | sort | while IFS= read -r var; do
  gum log --level info "  $var"
done
