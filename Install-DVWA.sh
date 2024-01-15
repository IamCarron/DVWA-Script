#!/bin/bash

# Actualiza la lista de paquetes e instala las dependencias necesarias
apt update
apt install -y apache2 default-mysql-server php php-gd php-mysql libapache2-mod-php git 

# Descarga DVWA desde GitHub
git clone https://github.com/ethicalhack3r/DVWA.git /var/www/html/DVWA

# Arranca MySQL
systemctl start mysql.service

# Configura la base de datos para DVWA
mysql -u root -e "CREATE DATABASE IF NOT EXISTS dvwa;"
mysql -u root -e "CREATE USER 'dvwa'@'localhost' IDENTIFIED BY 'abc123';"
mysql -u root -e "GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Configura DVWA
cp /var/www/html/DVWA/config/config.inc.php.dist /var/www/html/DVWA/config/config.inc.php
sed -i "s/\(\$_DVWA\[ 'db_password' \] = '\).*\('\)/\1abc123\2/" /var/www/html/DVWA/config/config.inc.php

# Configura permisos
chown -R www-data:www-data /var/www/html/DVWA
chmod -R 755 /var/www/html/DVWA

# Reinicia Apache
systemctl restart apache2

echo "Usuario y contrseña para el primer uso:"
echo "Usuario: dvwa"
echo "Contraseña: abc123"

echo "DVWA ha sido instalado correctamente. Accede a http://localhost/DVWA para comenzar."

echo "Credenciales tras setup:"
echo "Usuario: admin"
echo "Contraseña: password"
