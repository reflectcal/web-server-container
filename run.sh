#!/usr/bin/env bash
sudo docker run -v /etc/ssl:/etc/ssl -v /etc/letsencrypt:/etc/letsencrypt \
  -v /var/www/html:/var/www/html -p 80:80 -p 3000:3000 -p 443:443 \
  -e EMAIL='mail@example.com' \
  -e DOMAIN='example.com' \
  $1
