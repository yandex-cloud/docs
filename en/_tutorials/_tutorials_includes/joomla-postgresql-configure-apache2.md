1. Perform the basic configuration of Apache2:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo chown -R apache /var/www/html/
     ```

   {% endlist %}

1. Specify the virtual host settings in the Apache2 configuration file. You can edit files in the `nano` editor:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo nano /etc/httpd/conf.d/joomla.conf
     ```

     Edit the file as follows:

     ```xml
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

1. Restart the web server:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo service httpd restart
     ```

   {% endlist %}

1. Change the settings:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo restorecon -R /var/www/html
     sudo setsebool -P httpd_can_network_connect 1
     ```

   {% endlist %}