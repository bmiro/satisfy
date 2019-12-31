#!/bin/sh

echo "== Fixing '$APP_PATH/var' permissions =="
chown -R www-data "$APP_PATH/var/cache"
chown -R www-data "$APP_PATH/var/logs"
chown -R www-data "$APP_PATH/var/satis"

exec "$@"
