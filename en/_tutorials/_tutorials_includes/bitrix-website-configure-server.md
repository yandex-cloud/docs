To configure a server for 1C-Bitrix:
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH (use the `ubuntu` username you specified when [creating the VM](#create-vm)):

   ```bash
   ssh ubuntu@<VM_public_IP_address>
   ```

   To find out the public IP address of your VM, on the folder page in the [management console]({{ link-console-main }}):
   1. Select the **{{ compute-name }}** section.
   1. Click the name of your VM (**bitrixwebsite** in the example).
   1. A window will open with general information about your VM. You can find the public IP address in the **Public IPv4** field under **Network**.
1. Install the required software:

   ```bash
   sudo apt-get update
   sudo apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Go to the project's working directory and download the 1C-Bitrix: Site Management distribution:

   ```bash
   cd /var/www/html/
   sudo wget https://www.1c-bitrix.ru/download/standard_encode.tar.gz
   ```

1. Unpack the downloaded archive and delete unnecessary files:

   ```bash
   sudo tar -zxf standard_encode.tar.gz
   sudo rm -f index.html standard_encode.tar.gz
   ```

1. Make the `www-data` user the owner of the project's working directory:

   ```bash
   sudo chown -R www-data:www-data /var/www/html
   ```

   Check the permissions and owners of the working folder:

   ```bash
   ls -l
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
   ```

1. For 1C to work correctly, configure the PHP settings. To do this, use the built-in `nano` editor and modify the following variables in the `php.ini` configuration file:

   ```bash
   sudo nano /etc/php/8.1/apache2/php.ini
   ```

   | Previously | Now |
   :--- | :---
   | `short_open_tag = Off` | `short_open_tag = On` |
   | `memory_limit = 128M` | `memory_limit = 256M` |
   | `;date.timezone =` | `date.timezone = Europe/Moscow` |
   | `;opcache.revalidate_freq =2` | `opcache.revalidate_freq =0` |
   | `;session.save_path = "/var/lib/php/sessions"` | `session.save_path = "/var/lib/php/sessions"` |

   The `php.ini` file path depends on the PHP version installed. The example shows the path for version `8.1`. For version `8.0`, enter `/etc/php/8.0/apache2/php.ini`, for version`8.2`, enter `/etc/php/8.2/apache2/php.ini`, and so on.

   {% note tip %}

   To find the parameter you need in the `nano` editor, press **Ctrl** + **W**. Find the required parameter from the table above and save the changes using **Ctrl** + **O**. To exit the editor, press **Ctrl** + **X**.

   {% endnote %}

1. Configure the Apache web server. To do this, edit the `/etc/apache2/sites-enabled/000-default.conf` configuration file.
   1. Open the file in the text editor:

      ```bash
      sudo nano /etc/apache2/sites-enabled/000-default.conf
      ```

   1. Add the following block after the `DocumentRoot /var/www/html` line:

      ```html
      <Directory /var/www/html>
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
      </Directory>
      ```

   1. Restart the web server to apply all the new settings.

      ```bash
      sudo service apache2 restart
      ```

After you run these commands, the server side will be configured for 1C-Bitrix to work correctly.