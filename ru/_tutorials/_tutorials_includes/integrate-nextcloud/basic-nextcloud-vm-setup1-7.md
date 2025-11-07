Настройте виртуальный хост по умолчанию:

1. Откройте файл конфигурации виртуального хоста по умолчанию:

    ```bash
    sudo nano /etc/apache2/sites-available/000-default.conf
    ```
1. Замените содержимое открытого файла конфигурации `000-default.conf` на следующее:

    ```text
    <VirtualHost *:80>
    DocumentRoot /var/www/nextcloud/

    <Directory /var/www/nextcloud/>
    Require all granted
    AllowOverride All
    Options FollowSymLinks MultiViews

    <IfModule mod_dav.c>
    Dav off
    </IfModule>
    </Directory>
    </VirtualHost>
    ```