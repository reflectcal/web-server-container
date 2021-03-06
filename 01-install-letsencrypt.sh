#!/bin/sh
if [ ! -f /etc/ssl/certs/dhparam.pem ]; then
  echo "dhparam is not found"
  openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
else
  echo "dhparam is found"
fi
echo "Config without SSL:"
echo "\n"
cat /etc/nginx/nginx.conf
echo "Config finishes."
service nginx start -d
certbot certonly -n --webroot --webroot-path=/var/www/html -d ${DOMAIN} \
  -d www.${DOMAIN} --agree-tos --email ${EMAIL}
mv /etc/nginx/nginx.conf /etc/nginx/nginx.backup.conf
sed "s/DOMAIN/${DOMAIN}/g" /etc/nginx/nginx.ssl.conf | \
  sed "s/APP_SERVER_URL/${APP_SERVER_URL}/g" > /etc/nginx/nginx.conf
echo "Config with SSL:"
echo "\n"
cat /etc/nginx/nginx.conf
echo "Config finishes."
service nginx reload -d
crontab /etc/my_init.d/crontab
