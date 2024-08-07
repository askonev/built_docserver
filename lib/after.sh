#!/bin/bash

NAME=$1
PACKAGE_TYPE='onlyoffice-documentserver-ee'

# docker exec $NAME sudo supervisorctl start ds:example
docker exec $NAME sudo sed 's,autostart=false,autostart=true,' -i \
                            /etc/supervisor/conf.d/ds-example.conf

docker exec -it $NAME sed -i 's/WARN/ALL/g' \
                             /etc/onlyoffice/documentserver/log4js/production.json
docker exec -it $NAME sed -i 's,access_log off,access_log /var/log/onlyoffice/documentserver/nginx.access.log,' \
                             /etc/onlyoffice/documentserver/nginx/includes/ds-common.conf
docker exec -it $NAME dpkg-query --showformat='${Version}\n' --show $PACKAGE_TYPE

docker exec "$NAME" supervisorctl restart all

echo ''

docker exec $NAME  /var/www/onlyoffice/documentserver/npm/json -f \
                   /etc/onlyoffice/documentserver/local.json \
                   'services.CoAuthoring.secret.session.string'
docker exec $NAME cat /etc/supervisor/conf.d/ds-example.conf | grep autostart
