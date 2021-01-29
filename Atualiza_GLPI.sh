#!/bin/bash
echo "Iniciando atualização do GlPI 9.5.3"
echo "Efetue backup do banco de dados."
echo "Parando servico do Apache"
read -p "Pressione Enter para continuar!" -n 1 -r
systemctl stop apache2
apt-get update
apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://packages.sury.org/php/apt.gpg | apt-key add -
add-apt-repository "deb https://packages.sury.org/php/ $(lsb_release -cs) main"
apt-get update
echo "Atualizando versão do PHP"
php -v
read -p "Pressione Enter para continuar!" -n 1 -r
apt install php7.2-common php7.2-cli -y
apt-get install php7.2-mysql php7.2-curl php7.2-gd php7.2-simplexml php7.2-intl php7.2-ldap php7.2-apcu php7.2-zip php7.2-bz2 php7.2-xmlrpc php-mbstring php7.2-mbstring php-gettext -y
apt-get install php7.4-mysqli php7.4-curl php7.4-gd php7.4-simplexml php7.4-intl php7.4-ldap php7.4-xmlrpc php7.4-zip php7.4-bz2  -y
echo "Atualizando versão do apache"
read -p "Pressione Enter para continuar!" -n 1 -r
apt-get install php7.2 libapache2-mod-php -y
systemctl start apache2
echo "Desativando versão antiga do PHP"
read -p "Pressione Enter para continuar!" -n 1 -r
a2dismod php7.0
a2enmod php7.2
service apache2 restart
echo "Efetuando Backup pasta GLPI"
read -p "Pressione Enter para continuar!" -n 1 -r
mv /var/www/html/glpi /var/www/html/glpi_953
ls /var/www/html/
echo "Baixando GLPI 9.5.3"
read -p "Pressione Enter para continuar!" -n 1 -r
wget https://github.com/glpi-project/glpi/releases/download/9.5.3/glpi-9.5.3.tgz
tar -xvzf glpi-9.5.3.tgz
echo "Copiando pasta GLPI para o Apache"
read -p "Pressione Enter para continuar!" -n 1 -r
cp -Rf glpi /var/www/html/
echo "Efetuando recovery das pastas Pics e files"
read -p "Pressione Enter para continuar!" -n 1 -r
cp -Rf /var/www/html/glpi_953/pics /var/www/html/glpi
cp -Rf /var/www/html/glpi_953/files /var/www/html/glpi
echo "Instalando Plugins"
read -p "Pressione Enter para continuar!" -n 1 -r
wget https://forge.glpi-project.org/attachments/download/2316/glpi-behaviors-2.4.1.tar.gz
tar -xvzf glpi-behaviors-2.4.1.tar.gz
rm -Rf glpi-behaviors-2.4.1.tar.gz
wget https://github.com/fusioninventory/fusioninventory-for-glpi/releases/download/glpi9.5.0%2B1.0/fusioninventory-9.5.0+1.0.tar.bz2
tar -jxvf fusioninventory-9.5.0+1.0.tar.bz2
rm -Rf fusioninventory-9.5.0+1.0.tar.bz2
wget https://forge.glpi-project.org/attachments/download/2322/glpi-dashboard-1.0.1.zip
unzip glpi-dashboard-1.0.1.zip
rm -Rf 
cp -Rf behaviors /var/www/html/glpi/plugins
cp -Rf fusioninventory /var/www/html/glpi/plugins
cp -Rf dashboard /var/www/html/glpi/plugins
echo "Alterando permissão na pasta do GLPI"
read -p "Pressione Enter para continuar!" -n 1 -r
chown www-data. -Rf /var/www/html/glpi
chmod 775 -Rf /var/www/html/glpi
echo "Reiniciando serviço do Apache"
read -p "Pressione Enter para continuar!" -n 1 -r
systemctl restart apache2
echo "Atualização Finalizado! - Continuar a atualização via WEB" 


