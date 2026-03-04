FROM php:8.2-cli

WORKDIR /app

# Install system packages
RUN apt-get update && apt-get install -y \
    git unzip libpq-dev zip

# Install PHP extensions for PostgreSQL
RUN docker-php-ext-install pdo pdo_pgsql

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project
COPY . .

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

# Permissions
RUN chmod -R 777 storage bootstrap/cache

# Run migration and start server
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=$PORT