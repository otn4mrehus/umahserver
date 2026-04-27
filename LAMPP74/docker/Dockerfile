FROM php:7.4-apache

# Install system dependencies + mysqli
RUN apt-get update -y && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    default-mysql-client \
    zip \
    unzip \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install \
        gd \
        mbstring \
        zip \
        mysqli \
        pdo \
        pdo_mysql \
    && docker-php-ext-enable mysqli pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache modules
RUN a2enmod rewrite headers expires

# Set working directory
WORKDIR /var/www/html