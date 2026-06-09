FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    zip unzip curl libpng-dev \
    libonig-dev libxml2-dev \
    libzip-dev libgd-dev \
    libmagickwand-dev --no-install-recommends \
    && docker-php-ext-install \
    pdo_mysql mbstring bcmath \
    zip gd opcache \
    && pecl install imagick \
    && docker-php-ext-enable imagick

RUN a2enmod rewrite

RUN echo '<Directory /var/www/html>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' >> /etc/apache2/apache2.conf

WORKDIR /var/www/html
COPY . .

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/pp-content \
    && chmod -R 777 /var/www/html/pp-media

EXPOSE 80
