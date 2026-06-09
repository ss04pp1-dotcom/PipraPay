FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    zip unzip curl libpng-dev libonig-dev \
    libxml2-dev git \
    && docker-php-ext-install pdo_mysql mbstring

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
