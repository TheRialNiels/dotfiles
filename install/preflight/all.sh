source $TRND_INSTALL/preflight/guard.sh
source $TRND_INSTALL/preflight/begin.sh
run_logged $TRND_INSTALL/preflight/show-env.sh
run_logged $TRND_INSTALL/preflight/pacman.sh
run_logged $TRND_INSTALL/preflight/migrations.sh
run_logged $TRND_INSTALL/preflight/first-run-mode.sh
run_logged $TRND_INSTALL/preflight/disable-mkinitcpio.sh
