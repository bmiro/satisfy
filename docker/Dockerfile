FROM php:7.1-apache

RUN apt-get update -q \
    && apt-get install -qy git cron supervisor \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV COMPOSER_VERSION 1.9.1

RUN set -eux; \
  curl --silent --fail --location --retry 3 --output /tmp/installer.php --url https://raw.githubusercontent.com/composer/getcomposer.org/cb19f2aa3aeaa2006c0cd69a7ef011eb31463067/web/installer; \
  php -r " \
    \$signature = '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5'; \
    \$hash = hash('sha384', file_get_contents('/tmp/installer.php')); \
    if (!hash_equals(\$signature, \$hash)) { \
      unlink('/tmp/installer.php'); \
      echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
      exit(1); \
    }"; \
  php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION}; \
  composer --ansi --version --no-interaction; \
  rm -f /tmp/installer.php; \
  find /tmp -type d -exec chmod -v 1777 {} +


ADD conf/supervisor/* /etc/supervisor/conf.d/
ADD conf/cron.conf /etc/cron.d/satisfy
ADD conf/apache.conf /etc/apache2/sites-available/000-default.conf
ADD conf/php.ini /usr/local/etc/php/conf.d/php.ini
RUN a2enmod rewrite

RUN mkdir /var/www/.ssh && chown -R www-data:www-data /var/www
VOLUME /var/www/.ssh

# symbolic links to index.php and static files
ARG APP_PATH=/var/www/satisfy

WORKDIR /var/www/satisfy

ADD conf/entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
