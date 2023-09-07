FROM php:7.4-apache
LABEL Name=phpenv Version=0.0.1
ADD php.ini /usr/local/etc/php/conf.d
EXPOSE 80
EXPOSE 443
VOLUME ${PWD}/src:/var/www/html
#fix docker-php-ext-install bug
RUN sed -i 's/docker-php-\(ext-$ext.ini\)/\1/' /usr/local/bin/docker-php-ext-install

RUN usermod -u 431 www-data \
    && apt-get -y update && apt-get -y upgrade

RUN set -eux; apt-get update; apt-get install -y libzip-dev zlib1g-dev; docker-php-ext-install zip

# Install memcached
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y libmemcached-dev \
    && rm -rf /var/lib/apt/lists/* \
    && MEMCACHED="`mktemp -d`" \
    && curl -skL https://github.com/php-memcached-dev/php-memcached/archive/master.tar.gz | tar zxf - --strip-components 1 -C $MEMCACHED \
    && docker-php-ext-configure $MEMCACHED \
    && docker-php-ext-install $MEMCACHED \
    && rm -rf $MEMCACHED

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Config apache 
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf &&\
    a2enmod rewrite &&\
    service apache2 restart

# APT install gd
# APT install ghostscript
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# APT install ghostscript
RUN apt-get install -y ghostscript

# APT install imagick
RUN apt-get install --assume-yes --no-install-recommends --quiet \
    build-essential \
    libmagickwand-dev

# APT install imagick
RUN pecl install imagick \
    && docker-php-ext-enable imagick

# APT install pdftk
RUN apt-get -y install pdftk


# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# VOLUME ./php/tmp:/tmp
# WORKDIR "/tmp"

# ENTRYPOINT ["/opt/libreoffice/entrypoint.sh"]