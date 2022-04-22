FROM php:7.4-apache
LABEL Name=phpenv Version=0.0.1
ADD php.ini /usr/local/etc/php/conf.d
EXPOSE 80
EXPOSE 443
VOLUME ${PWD}/src:/var/www/html
#fix docker-php-ext-install bug
RUN sed -i 's/docker-php-\(ext-$ext.ini\)/\1/' /usr/local/bin/docker-php-ext-install

RUN usermod -u 431 www-data

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
RUN apt-get -y update && apt-get -y upgrade

# Config apache 
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf &&\
    a2enmod rewrite &&\
    service apache2 restart

# APT install gd
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# APT install memcached and extension
# RUN apt-get install -y libmcached-dev zlib1g-dev &&\
#     pecl install memcached-3.1.5 &&\
#     docker-php-ext-enable memcached

# APT install ghostscript
RUN apt-get install -y ghostscript

# APT install imagick
RUN apt-get install --assume-yes --no-install-recommends --quiet \
    build-essential \
    libmagickwand-dev

RUN pecl install imagick \
    && docker-php-ext-enable imagick

# APT install pdftk
RUN apt-get -y install pdftk

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install libreoffice
# ENV DEBIAN_FRONTEND noninteractive
# RUN apt-get update && \
#     apt-get -y -q install \
#     libreoffice \
#     libreoffice-writer \
#     ure \
#     libreoffice-java-common \
#     libreoffice-core \
#     libreoffice-common \
#     openjdk-8-jre \
#     fonts-opensymbol \
#     hyphen-fr \
#     hyphen-de \
#     hyphen-en-us \
#     hyphen-it \
#     hyphen-ru \
#     fonts-dejavu \
#     fonts-dejavu-core \
#     fonts-dejavu-extra \
#     fonts-droid-fallback \
#     fonts-dustin \
#     fonts-f500 \
#     fonts-fanwood \
#     fonts-freefont-ttf \
#     fonts-liberation \
#     fonts-lmodern \
#     fonts-lyx \
#     fonts-sil-gentium \
#     fonts-texgyre \
#     fonts-tlwg-purisa && \
#     apt-get -y -q remove libreoffice-gnome && \
#     apt -y autoremove && \
#     rm -rf /var/lib/apt/lists/*

# RUN adduser --home=/opt/libreoffice --disabled-password --gecos "" --shell=/bin/bash libreoffice

# ADD ./libreoffice-entrypoint.sh /opt/libreoffice/entrypoint.sh
# RUN chmod +x /opt/libreoffice/entrypoint.sh

# VOLUME ./php/tmp:/tmp
# WORKDIR "/tmp"

# ENTRYPOINT ["/opt/libreoffice/entrypoint.sh"]