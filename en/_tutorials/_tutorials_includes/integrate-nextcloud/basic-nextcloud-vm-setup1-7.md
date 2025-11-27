Configure the default virtual host:

1. Open the configuration file of the default virtual host:

    ```bash
    sudo nano /etc/apache2/sites-available/000-default.conf
    ```
1. Replace the contents of `000-default.conf` with the following:

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