FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    zip unzip curl libpng-dev \
    libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring

RUN a2enmod rewrite

WORKDIR /var/www/html
COPY . .

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/pp-content \
    && chmod -R 777 /var/www/html/pp-media

EXPOSE 80
