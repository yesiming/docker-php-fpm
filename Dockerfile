FROM php:7.1-fpm-alpine
MAINTAINER simon simon@yesiming.com
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk add --update --no-cache --virtual .ext-deps \
        libjpeg-turbo-dev \
        libwebp-dev \
        libpng-dev \
        freetype-dev \
        libmcrypt-dev \
        autoconf \
        libressl-dev \
        g++ \
        make \
        curl \
        curl-dev \
        php7-openssl \
        php7-curl

RUN apk add --no-cache \
    libmcrypt-dev \
    libltdl \
    && docker-php-ext-configure mcrypt \
    && docker-php-ext-install mcrypt

RUN \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-configure opcache && \
    docker-php-ext-configure exif && \
    docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/include --with-png-dir=/usr/include --with-webp-dir=/usr/include --with-freetype-dir=/usr/include && \
    docker-php-ext-configure sockets && \
    docker-php-ext-install pdo_mysql opcache exif gd sockets


RUN \
    pecl channel-update pecl.php.net && \
    pecl install redis && \
    pecl install mongodb && \
    docker-php-ext-enable redis mongodb && \
    pecl clear-cache && \
    docker-php-source delete

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN docker-php-ext-install bcmath