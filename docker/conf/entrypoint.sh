#!/bin/sh

chown -R www-data "$APP_PATH/var/cache"
chown -R www-data "$APP_PATH/var/log"
chown -R www-data "$APP_PATH/var/satis"

supervisor -n
