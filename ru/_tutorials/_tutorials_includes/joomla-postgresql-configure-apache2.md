1. Выполните базовую настройку Apache2:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo chown -R apache /var/www/html/
     ```

   {% endlist %}

1. Задайте настройки виртуального хоста в конфигурационном файле Apache2. Вы можете отредактировать файл с помощью редактора `nano`:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo nano /etc/httpd/conf.d/joomla.conf
     ```

     Приведите файл к виду:

     ```
     <VirtualHost *:80 [::]:80>
       ServerAdmin webmaster@localhost
       DocumentRoot /var/www/html/

       <Directory /var/www/html/>
         DirectoryIndex index.php index.html
         DirectorySlash off
         RewriteEngine on
         RewriteBase /
         AllowOverride all
       </Directory>
     </VirtualHost>
     ```

   {% endlist %}

1. Перезапустите веб-сервер:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo service httpd restart
     ```

   {% endlist %}

1. Измените настройки:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo restorecon -R /var/www/html
     sudo setsebool -P httpd_can_network_connect 1
     ```

   {% endlist %}