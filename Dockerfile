############################################################
# Dockerfile to build Nginx with Letsencrypt
############################################################

# Set the base image to Ubuntu
FROM alexeykomov/nginx-letsencrypt-container:latest

COPY 01-install-letsencrypt.sh /etc/my_init.d/01-install-letsencrypt.sh
COPY nginx.ssl.conf /etc/nginx/nginx.ssl.conf
RUN chmod +x /etc/my_init.d/01-install-letsencrypt.sh
COPY crontab /etc/my_init.d/crontab

# Copy static files of web-app
COPY ./src/static /var/www/html/static/
