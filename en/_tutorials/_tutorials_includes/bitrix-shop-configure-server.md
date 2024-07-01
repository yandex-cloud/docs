To configure a VM for 1C-Bitrix:
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH (use the `ubuntu` username you specified when [creating the VM](#create-vm)):

   ```bash
   ssh ubuntu@<VM_public_IP_address>
   ```

   To find out the public IP address of your VM:
   1. Select the folder the VM is in using the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. Click the name of your VM (`bitrix` in this example).
   1. In the window with general VM info that opens, you can find the public IP address in the **Public IPv4** field under **Network**.
1. Switch to admin mode:

   ```bash
   ubuntu@bitrix:~$ sudo -i
   root@bitrix:~#
   ```

1. Install the required software:

   ```bash
   root@bitrix:~# apt-get update
   root@bitrix:~# apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Go to the project's working directory:

   ```bash
   root@bitrix:~# cd /var/www/html/
   ```

1. Download the 1C-Bitrix: Site Management distribution:

   ```bash
   root@bitrix:/var/www/html# wget https://www.1c-bitrix.ru/download/business_encode.tar.gz
   ```

1. Unpack the downloaded archive and delete unnecessary files:

   ```bash
   root@bitrix:/var/www/html# tar -zxf business_encode.tar.gz
   root@bitrix:/var/www/html# rm -f index.html business_encode.tar.gz
   ```

1. Make the `www-data` user the owner of the project's working directory:

   ```bash
   root@bitrix:/var/www/html# chown -R www-data:www-data /var/www/html
   ```

   Make sure the previous command has run properly.

   ```bash
   root@bitrix:/var/www/html# ls -l
   ```

   Result:

   ```text
   total 76
   drwxrwxr-x 6 www-data www-data  4096 May 15 13:50 bitrix
   -rwxrwxr-x 1 www-data www-data  1378 May 15 13:50 index.php
   -rwxrwxr-x 1 www-data www-data   150 Mar 11  2013 install.config
   -rwxrwxr-x 1 www-data www-data 30741 Apr 10 14:36 license.html
   -rwxrwxr-x 1 www-data www-data   113 Nov 20  2012 license.php
   -rwxrwxr-x 1 www-data www-data 14054 Feb  6  2017 readme.html
   -rwxrwxr-x 1 www-data www-data   112 Mar 27  2013 readme.php
   drwxrwxr-x 2 www-data www-data  4096 May 15 13:50 upload
   -rwxrwxr-x 1 www-data www-data   691 Oct 27  2009 web.config
   ...
   ```

1. Open the `/etc/php/7.4/apache2/php.ini` configuration file and specify the required PHP settings.

   {% note info %}

   The path to the configuration file may differ depending on the 1C-Bitrix version. Specify the path to the current PHP version on the VM.

   {% endnote %}

   | Previously | Now |
   :--- | :---
   | `short_open_tag = Off` | `short_open_tag = On` |
   | `display_errors = Off` | `display_errors = On` |
   | `memory_limit = 128M` | `memory_limit = 256M` |
   | `;date.timezone =` | `date.timezone = Europe/Moscow` |
   | `;opcache.revalidate_freq=2` | `opcache.revalidate_freq = 0` |
   | `;mbstring.func_overload = 0` | `mbstring.func_overload = 2` |

1. Configure the Apache server using the `/etc/apache2/sites-enabled/000-default.conf` file. To do this, add the following block after the `DocumentRoot /var/www/html` line:

   ```xml
   <Directory /var/www/html>
     Options Indexes FollowSymLinks
     AllowOverride All
     Require all granted
   </Directory>
   ```

1. Restart the Apache server to apply all the new settings:

   ```bash
   root@bitrix:/var/www/html# service apache2 restart
   ```

The server is configured for 1C-Bitrix to work correctly. Now you need to configure 1C-Bitrix.