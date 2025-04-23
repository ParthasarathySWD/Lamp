FROM ubuntu:22.04

LABEL Name=phpenv Version=0.0.1

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install GPG and required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    gnupg2 \
    gpg-agent \
    ca-certificates \
    apt-transport-https

# Add PHP repository and update
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && apt-get update

# Install PHP and required packages
RUN apt-get install -y --no-install-recommends \
    apache2 \
    php8.2 \
    php8.2-cli \
    php8.2-common \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-zip \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-curl \
    php8.2-xml \
    php8.2-bcmath \
    php8.2-imagick \
    libapache2-mod-php8.2 \
    libzip-dev \
    zlib1g-dev \
    libmemcached-dev \
    libfreetype6-dev \
    libpng-dev \
    ghostscript \
    pdftk \
    qpdf \
    poppler-utils \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PHPMyAdmin
RUN mkdir -p /var/www/html/phpmyadmin && \
    cd /var/www/html/phpmyadmin && \
    curl -O https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.gz && \
    tar xvf phpMyAdmin-5.2.1-all-languages.tar.gz && \
    mv phpMyAdmin-5.2.1-all-languages/* . && \
    rm -rf phpMyAdmin-5.2.1-all-languages.tar.gz phpMyAdmin-5.2.1-all-languages && \
    chown -R www-data:www-data /var/www/html/phpmyadmin

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy custom php.ini if it exists
COPY php.ini /etc/php/8.2/apache2/conf.d/custom.ini

# Configure Apache
RUN a2enmod rewrite \
    && a2enmod php8.2 \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set working directory
WORKDIR /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port
EXPOSE 80

# Start Apache in foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]