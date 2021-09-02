
FROM yeszao/php:5.4.45-fpm-alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
&& apk update && apk add --no-cache autoconf openssl-dev g++ make && \
    apk del --purge autoconf openssl-dev g++ make


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer