FROM php:8.2-apache

RUN apt-get update && \
    apt-get install -y \
    curl unzip sqlite3

COPY scripts/symfony.conf /etc/apache2/sites-available/
COPY scripts/script-1.sh /script-1.sh
COPY Application/fastlist.zip /var/www/

RUN chmod +x /script-1.sh

RUN /script-1.sh

EXPOSE 80

CMD ["apache2-foreground"]