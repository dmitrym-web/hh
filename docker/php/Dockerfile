FROM php:8.4-fpm-alpine

# Install packages
RUN apk add --no-cache curl git build-base zlib-dev icu-dev oniguruma-dev autoconf bash
RUN apk add --update linux-headers

COPY ./docker/php/php.ini /usr/local/etc/php/conf.d/extra-php-config.ini

RUN docker-php-ext-configure intl && docker-php-ext-install intl && docker-php-ext-enable intl

# Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug
COPY ./docker/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Redis
RUN pecl install redis && docker-php-ext-enable redis

# Configure non-root user.
ARG PUID=1000
ARG PGID=1000
RUN apk --no-cache add shadow && \
    groupmod -o -g ${PGID} www-data && \
    usermod -o -u ${PUID} -g www-data www-data

# Source code
COPY ./../ /var/www
WORKDIR /var/www

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
#RUN composer install --no-interaction

# Symfony-cli
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | bash \
    && apk add symfony-cli

CMD php-fpm

EXPOSE 9000