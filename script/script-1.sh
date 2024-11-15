#!/bin/bash

# Désactiver le site par défaut et activer celui de Symfony
a2dissite 000-default.conf
a2ensite symfony.conf
a2enmod rewrite

# Décompresser et installer l'application si le fichier zip existe
if [ -f /var/www/fastlist.zip ]; then
    echo "Décompression de fastlist.zip..."
    unzip /var/www/fastlist.zip -d /var/www/
    rm -f /var/www/fastlist.zip
    chown -R www-data:www-data /var/www/
    chmod -R 755 /var/www/
else
    echo "Erreur : fastlist.zip non trouvé!"
    exit 1
fi

# Installer Composer et gérer les dépendances
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer --version
cd /var/www/fastlist || exit 1
composer install

# Modifier le fichier .env pour l'environnement de production
sed -i 's/APP_ENV=dev/APP_ENV=prod/' /var/www/fastlist/.env

# Vider le cache Symfony pour l'environnement de production
php /var/www/fastlist/bin/console cache:clear --no-warmup --env=prod

# Configurer les permissions
chmod -R 777 /var/www/fastlist/var/
echo "Permissions configurées pour /var/www/fastlist/var/"

# Vider le cache Symfony (pas besoin de redémarrer Apache dans Docker)
echo "Vider le cache Symfony..."
cd /var/www/fastlist/
php bin/console cache:clear
