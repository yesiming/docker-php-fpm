FROM php:5.6-fpm-alpine
MAINTAINER simon simon@yesiming.com
RUN apk update && apk add --no-cache autoconf openssl-dev g++ make && \
    pecl install mongo && \
    docker-php-ext-enable mongo && \
    pecl install mongodb-1.4.5 && \
    docker-php-ext-enable mongodb && \
    apk del --purge autoconf openssl-dev g++ make


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
