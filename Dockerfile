############################################################
# Dockerfile to build Nginx with Letsencrypt
############################################################

# Set the base image to Ubuntu
FROM phusion/baseimage:latest

# File Author / Maintainer
MAINTAINER Alex K <alexeykcontact@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Install Nginx
# Add application repository URL to the default sources
RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list
# Update the repository
RUN apt-get update; exit 0
# Install necessary tools
RUN apt-get install -y nano wget dialog net-tools
# Download and Install Nginx
RUN apt-get install -y nginx

# Copy static files of web-app
COPY ../build/reflectcal/build/* /var/www/html

# Install Letsencrypt
RUN add-apt-repository ppa:certbot/certbot
RUN apt-get update; exit 0
RUN apt-get install -y certbot

# Init
RUN mkdir -p /etc/my_init.d
COPY 01-install-letsencrypt.sh /etc/my_init.d/01-install-letsencrypt.sh
COPY crontab-changed /etc/my_init.d/crontab-changed
COPY nginx.ssl.conf /etc/nginx/nginx.ssl.conf
RUN chmod +x /etc/my_init.d/01-install-letsencrypt.sh
