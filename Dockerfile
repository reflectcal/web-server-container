############################################################
# Dockerfile to build Nginx with Letsencrypt
############################################################

# Set the base image to Ubuntu
FROM alexeykomov/nginx-letsencrypt-container:latest

# Copy static files of web-app
COPY ./src/static /var/www/html/static/