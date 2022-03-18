FROM php:8.1-apache-buster
RUN apt-get update;
RUN apt-get install -y libzip-dev;
RUN docker-php-ext-install zip pdo_mysql mysqli
#RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN a2enmod ssl rewrite proxy proxy_http substitute
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
COPY ./docker_config/web/web.conf /etc/apache2/sites-available/web.conf
RUN a2ensite web
RUN mkdir -p /var/www/html/laravel9/public
RUN mkdir -p /var/www/html/docker_config/web/logs/
RUN a2dissite 000-default
COPY ./docker_config/web/ssl/ssl.crt /etc/ssl/certs/ssl.crt
COPY ./docker_config/web/ssl/ssl.key /etc/ssl/private/ssl.key
RUN apachectl configtest
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
#RUN echo '#コメントアウト' > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo '#extension=xdebug' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo 'zend_extension=xdebug.so' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo 'xdebug.mode=coverage' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

