#!/bin/bash

TOOLS_DIR=/var/www/onlyoffice/documentserver/server/tools
SDKJS_PLUGINS_DIR=/var/www/onlyoffice/documentserver/sdkjs-plugins
PM=pluginsmanager

_pm_install() {
    docker exec "$2" ./"$TOOLS_DIR/$PM" \
                    --directory="$SDKJS_PLUGINS_DIR" \
                    --install=$1
}
