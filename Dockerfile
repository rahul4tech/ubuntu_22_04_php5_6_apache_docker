FROM ubuntu:22.04

# Maintainer of this Dockerfile
LABEL maintainer="Rahul Sinha"

# name of the image
LABEL name="ubuntu22.04_apache-php5.6"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
#  install software-properties-common
RUN apt-get install -y software-properties-common
# Add PPA for PHP 5.6
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get update -y
RUN apt-get install -y apache2 php5.6 php5.6-mysql php5.6-mbstring php5.6-gettext php5.6-curl php5.6-gd php5.6-intl php5.6-json php5.6-xml php5.6-zip php5.6-dom php5.6-simplexml

# Enable apache mods.
RUN a2enmod php5.6
RUN a2enmod rewrite

# Remove default apache index.html
RUN rm -rf /var/www/html/index.html

# Create Custom index.php with phpinfo()
RUN echo "<?php phpinfo(); ?>" > /var/www/html/index.php

# Configure Apache to log to stdout and stderr
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

# start apache service
CMD apachectl -D FOREGROUND

# port 80
EXPOSE 80