FROM php:8.2-cli

WORKDIR /app

RUN apt-get update && apt-get install -y git unzip libzip-dev zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN chmod -R 777 storage bootstrap/cache

CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=$PORT