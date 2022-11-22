# Transferring a WordPress website from a different hosting provider to {{ yandex-cloud }}

[WordPress](https://wordpress.com) is an open-source content management system.

With WordPress, you can create news sites, personal or corporate blogs, business websites, online stores, and other services.

It allows you to launch your website with minimal effort using one of the many available templates or your own design. Ready-made plugins help you easily add new blocks or features to a created service.

In {{ yandex-cloud }}, you can quickly [create a website on WordPress](../../tutorials/web/wordpress.md) or transfer from another hosting provider.

To transfer a WordPress CMS website to {{ yandex-cloud }}:

1. [Create a backup of the site](#create-backup).
1. [Before you start](#before-begin).
1. [Create a VM for WordPress](#create-vm).
1. [Connect to the VM](#connect-vm).
1. [Install and configure additional components](#additional-components).
1. [Import the database](#import-db).
1. [Transfer the site files](#transfer-files).
1. [Configure DNS](#configure-dns).
1. [Create an SSL certificate](#setting-ssl).
1. [Check the operability of the site](#check-site).

## Make a backup of the site {#create-backup}

Make a backup of the site and database files using one of the following methods:

* Using various plugins for WordPress (for example, [BackWPup]({% if lang == "ru" %} https://ru.wordpress.org/plugins/backwpup {% endif %} {% if lang == "en" %} https://wordpress.org/plugins/backwpup {% endif %}) or [Updraft Plus]({% if lang == "ru" %} https://ru.wordpress.org/plugins/updraftplus {% endif %} {% if lang == "en" %} https://wordpress.org/plugins/updraftplus {% endif %})).
* Using built-in tools from the hosting control panel for your website.
* Copying all the files to your hard drive using an FTP client and exporting the database using the [phpMyAdmin](https://www.phpmyadmin.net/) panel.
  This method is longer and will take 5 to 20 minutes because you need to copy numerous small files that make up your site.

## Before you start {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Make sure the selected folder has a cloud network with a subnet in at least one availability zone. To do this, select **{{ vpc-name }}** on the folder page. If the list contains a network, click on its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of hosting a website in WordPress includes:

* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for public DNS queries and zones (see [{{ dns-full-name }} pricing]{% if lang == "ru" %}(https://cloud.yandex.ru/docs/dns/pricing){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en/docs/dns/pricing){% endif %}).

{% endif %}

## Create a virtual machine for WordPress {#create-vm}

To create a VM:

1. Open the folder page in the [management console]({{ link-console-main }}).

1. In the upper-right corner, click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name `wordpress-vm`.

   {% include [name-format](../../_includes/name-format.md) %}

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM. If you don't know which availability zone you need, leave the default.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the [LAMP](/marketplace/products/yc/lamp): an image with a set of necessary components: Linux OS, Apache web server, MySQL DBMS, and a PHP interpreter.

1. Under **Disks**, select the disk type and set the size.

1. Under **Computing resources**:
   * Choose a [platform](../../compute/concepts/vm-platforms.md) for your VM.
   * Specify the necessary number of vCPUs and amount of RAM.

   For a regular WordPress site, the minimum configuration is enough:
   * **Platform**: Intel Ice Lake.
   * **Guaranteed vCPU share**: 20%.
   * **vCPU**: 2.
   * **RAM**: 1 GB.

1. Under **Network settings**, select the network and subnet to connect the VM to. If you don't have a network or subnet, create them on the VM creation page.

1. Under **Public address**, keep **Auto** to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

1. Enter the VM access information:
   * Select a service account or create a new one.
   * Enter the username in the **Login** field.
   * In the **SSH key** field, paste the contents of the public key file.
     You will need to create a key pair for the SSH connection yourself, see [{#T}](../../compute/operations/vm-connect/ssh.md).

   {% note alert %}

   Once created, the VM will be assigned an IP address and a host name (FQDN) for connections. If you selected **No address** in the **Public address** field, you won't be able to access the VM from the internet.

   {% endnote %}

1. Click **Create VM**.

   The VM may take several minutes to create. When the VM status changes to `RUNNING`, you can [upload the website files](#upload-files).

## Connect to the VM {#connect-vm}

You can connect to a VM using the SSH protocol when it is running (the VM's status is `RUNNING`). You can use the `ssh` tool in Linux/macOS/Windows 10 or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows 7/8.

To connect to a VM, you must specify its public address.

To copy a VM's public address:

1. Open the folder page in the [management console]({{ link-console-main }}).

1. Select **{{ compute-short-name }}**.

1. In the menu on the left, select **Virtual machines**.

1. Locate the created VM and click on its name.

1. Under **Network**, copy the address from the **Public IPv4** field.

Run the [connection to a virtual machine](../../compute/operations/vm-connect/ssh.md).

## Install and configure additional components {#additional-components}

Before you transfer your files, do the following:

* Install the text editor `nano`. You need it to edit some of the configuration files.
* Install and configure `phpMyAdmin` to manage the site database.

### Install the nano editor {#install-nano}

{% list tabs %}

- Ubuntu

  Run the command:

  ```bash
    sudo apt install nano
  ```

  Wait for the editor to be installed.

{% endlist %}

### Install phpMyAdmin {#install-phpmyadmin}

{% list tabs %}

- Ubuntu

    1. Run the following commands:

        ```bash
        sudo apt-get update
        sudo apt-get install phpmyadmin php-mbstring php-gettext
        ```

    1. During the installation process, select the server to install `phpMyAdmin` on. Select `Apache2` and press the **space bar** on the keyboard: the `*` symbol appears next to `Apache2`. Click **Enter**.

    1. Configure access of `phpMyAdmin` to the database. To do this, answer the question `Configure database for phpmyadmin with dbconfig-common?` with `<yes>`. You can skip entering the password, the system will automatically generate it. To copy the generated password, run the command:

        ```bash
        sudo cat /root/default_passwords.txt
        ```

        The text of the file must contain the following data:

        ```bash
        MYSQL_PASS=DOEC21WECnhF1 
        MYSQL_ROOT_PASS=KjZKrQV7efFGk 
        MYSQL_USER=wordpress 
        MYSQL_DB=wordpress
    
        Apache Web Auth:
        login: admin 
        password: ***************
        ```

        Copy and save the contents of the `default_passwords.txt` file to my computer.

    1. Enable the `mbstring` extension for PHP:

        ```bash
        sudo phpenmod mbstring
        ```

    1. To accept all changes, restart Apache:

        ```bash
        sudo systemctl restart apache2
        ```

    1. Open `phpMyAdmin` in the browser. In the address bar, enter `http://<public address of the VM>/phpmyadmin`.

        To log in to `phpMyAdmin` use the following data:

        ```text
        User: root
        Password: generated by the system (from the default_passwords.txt file)
        ```

{% endlist %}

### Configure phpMyAdmin {#setting-phpmyadmin}

Set up an additional password to log in to the `phpMyAdmin` panel. To enable the use of access settings in `.htaccess`, edit the `phpmyadmin.conf` file.

{% list tabs %}

- Ubuntu

    1. Run the command:

        ```bash
        sudo nano /etc/apache2/conf-available/phpmyadmin.conf
        ```

    1. Add the `AllowOverride All` line to the `phpmyadmin.conf` file:

        ```bash
        <Directory /usr/share/phpmyadmin>
        Options SymLinksIfOwnerMatch
        DirectoryIndex index.php
        AllowOverride All
        ```

    1. Save the changes in the `phpmyadmin.conf` file. To do this, click **Ctrl** + **O** and **Enter**. To exit the file, click **Ctrl** + **X**.

    1. Restart Apache:

        ```bash
        sudo systemctl restart apache2
        ```

    1. Create `.htaccess`:

        ```bash
        sudo nano /usr/share/phpmyadmin/.htaccess
        ```

    1. Copy the lines to `.htaccess`:

        ```bash
        AuthType Basic
        AuthName "Restricted Files"
        AuthUserFile /etc/phpmyadmin/.htpasswd
        Require valid-user
        ```

    1. Save the changes in the file.

    1. Create `.htpasswd`:

	     ```bash
	     sudo htpasswd -c /etc/phpmyadmin/.htpasswd <username>
	     ```

        Set the desired password and repeat it.

    1. Restart Apache:

        ```bash
        sudo systemctl restart apache2
        ```

	 Now, when you log in to phpMyAdmin, you will need to enter an additional username and password specified in the `.htpasswd` file.

{% endlist %}

## Import the database {#import-db}

{% list tabs %}

- Ubuntu

    1. Open the WordPress configuration file of your website. To do this, unpack the archive and open `wp-config.php` in the root folder. Find the values of the `DB_USER`, `DB_NAME`, and `DB_PASSWORD` parameters:

        ```bash
        define('DB_USER', 'UsernameTEST');
        define('DB_NAME', 'database_wordpress');
        define('DB_PASSWORD', 'MySecretPassword');
        ```

    1. Log in to phpMyAdmin: enter the following in the browser address bar:

        ```
        http://<VM's public address/phpmyadmin`
        ```

    1. Go to the **User accounts** section and add a user account with the following parameters:

        * **Username**: Insert a value of `DB_USER` from `wp-config.php`.
        * **Hostname**: Leave the default value `%`.
        * **Password**: Insert a value for `DB_PASSWORD` from `wp-config.php`.
        * **Global privileges**: Enable the **Mark all** option.

        Leave the other default parameters when creating a user. At the bottom of the screen, click **Forward**.

    1. Go to the **Databases** section. Complete the **Database name** field with a value for `DB_NAME` from `wp-config.php`. Select the `utf8_general_ci` encoding. Click **Create**.

    1. Import the database from a backup:

        * In the left column, select the database you created.
        * Click **Import** and select the saved database backup. If the database backup exceeds the default limit of 2 MB, edit the configuration file `php.ini` where this restriction is set.

        1. Run the command:

           ```bash
	        sudo nano /etc/php/X.X/apache2/php.ini
	        ```
	        `X.X`: php version. Possible values `5.6`,`7.0`,`7.1`,`7.2`,`7.3`,`7.4`,`8.0`, and `8.1`.

        1. Edit the parameters:

           * `upload_max_filesize`: The maximum size of the uploaded file.
           * `post_max_size`: The maximum amount of `POST` method data allowed.

           ```bash
           upload_max_filesize = 80M
           post_max_size = 80M
           ```
        1. Save the changes: press **Ctrl** + **O** and **Enter**. To exit the file, press **Ctrl** + **X**.

        1. Restart Apache:

           ```bash
           sudo systemctl restart apache2
           ```

        1. Repeat the database import operation.

{% endlist %}

### Disable phpMyAdmin {#disable-phpmyadmin}

All the main migration activities on the database are performed. In order not to expose `phpMyAdmin` to attacks from outside, disable the utility:

{% list tabs %}

- Ubuntu

    ```bash
    sudo a2disconf phpmyadmin.conf && sudo /etc/init.d/apache2 restart
    ```

{% endlist %}

You can use the terminal to work with the database.

## Transfer the site files {#transfer-files}

To transfer backup files to a virtual machine, use the [FileZilla](https://filezilla-project.org/) FTP client:

1. Open FileZilla.

1. Go to **File** → **Site manager** and add a new website.

1. Select SFTP and enter the public IP address of the virtual machine. Under **Logon type**, select **File with the key**.

1. Specify the user created when configuring the VM and select the key file (located in the `/Users/<user_name>/.ssh/`).

   The FTP client doesn't see the hidden folder by default. Press the keyboard shortcut **Cmd** + **Shift** + **G** and select the file `id_rsa` without the `pub` extension. A message is displayed that the file is not supported. The FTP client will offer to convert it to the desired format. Click **Yes**. Save the converted file in a convenient location.

1. Click **Connect** and enter the passphrase that you created at the beginning of the work. You'll be connected to the VM.

1. Find the `/var/www/html` folder on the VM and copy the backup file there. You don't need to copy index.html.

   {% list tabs %}

   - Ubuntu

     By default, this folder requires 755 rights. To copy the archive file of the site from your hard drive to the `html` folder, change the rights to the folder:

     ```bash
     sudo chmod 777 /var/www/html
     ```

     Unpack the backup:

     ```bash
     cd /var/www/html
     tar -xvf FILENAME.tar.gz
     ```

     Instead of `FILENAME`, specify the name of the archive file of the site.

     {% note alert %}

     You should unpack all the files to the root directory `html`, not to the subdirectory `/var/www/html/wordpress`.

     {% endnote %}

     Delete the backup file so that it does not take up space:

     ```bash
     rm FILENAME.tar.gz
     ```

     Return the rights to the folders:

        * `html` and subfolders: `755`.
        * For all files inside `html`: `644`.
        * For `wp-config.php`, an individual access level: `600`.

     ```bash
     cd var/www/
     sudo find ./ -type d -exec chmod 0755 {} \;
     sudo find ./ -type f -exec chmod 0644 {} \;
     sudo chmod 600 wp-config.php
     ```

     The `f` parameter: searches for all files inside folders. The `d` parameter: searches for all folders inside `html`.

   {% endlist %}

## Configure the DNS {#configure-dns}

Use {{ dns-name }} to manage the domain.

{% include [configure-a-record-and-cname](../web/configure-a-record-and-cname.md) %}

### Check that the website is running {#test-site}

To check that the site is up, enter its IP address or domain name in your browser:

* `http://<virtual machine public IP address>`.
* `http://www.example.com`.

## Install the SSL certificate using Let's Encrypt® {#setting-ssl}

To install the certificate, use [Let’s Encrypt](https://letsencrypt.org/). Let's Encrypt is a certificate authority that offers free [SSL certificates]({% if lang == "ru" %} https://ru.wikipedia.org/wiki/SSL {% endif %} {% if lang == "en" %} https://wikipedia.org/wiki/SSL {% endif %}).

### Install the Let's Encrypt client {#install-client}

{% list tabs %}

- Ubuntu

    1. Enter the following command in the terminal:

        ```bash
        sudo apt-get update && sudo apt-get install software-properties-common
        ```

    1. Add the `unverse` and `certbot` repositories:

        ```bash
        sudo add-apt-repository universe && sudo add-apt-repository ppa:certbot/certbot
        ```

        Click **Enter**.

    1. Install the Let's Encrypt client:

        ```bash
        sudo apt-get update && sudo apt-get install certbot python-certbot-apache
        ```

    1. Click **Y** and **Enter**.

{% endlist %}

### Get an SSL certificate{#get-ssl}

{% list tabs %}

- Ubuntu

    1. Enter the command:

        ```bash
        sudo certbot --apache
        ```

    1. In the interface, enter the name of your domain `example.com` or `www.example.com`.

    1. Decide if you need to redirect all pages from `http` on `https` when opening a website. Select `2`: redirect to https.

    1. Test your site: enter `https://www.ssllabs.com/ssltest/analyze.html?d=example.com` in the address bar of the browser.

{% endlist %}

### Perform auto-update {#self-update}

The certificate is issued for 90 days. You need to to update it regularly. Configure the update schedule using `cron`:

{% list tabs %}

- Ubuntu

    1. Enter the following command in the terminal:

        ```bash
        sudo crontab -e
        ```

    1. In the dialog, select the first item from the list.

    1. Add a line of code to the very end of the file:

        ```bash
        30 2 * * 1 /usr/bin/certbot renew >> /var/log/le-renew.log
        ```

        As a result, an SSL certificate is scheduled to be updated every Monday at 2:30 am. The result will be recorded in a log file.

{% endlist %}

## Check that the website is running {#check-site}

WordPress sites sometimes have a problem opening internal links when switching from one host to another.

In this case, check whether the `.htaccess` file exists in your site's root folder: `var/www/html/.htaccess`.

If there is no file, create it.

{% list tabs %}

- Ubuntu

    1. Enter the following command in the terminal:

        ```bash    
        sudo nano /var/www/html/.htaccess
        ```

    1. Add a code:

        ```bash
        <IfModule mod_rewrite.c>
		     RewriteEngine On
		     RewriteBase /
		     RewriteRule ^index\.php$ - [L]
		     RewriteCond %{REQUEST_FILENAME} !-f
		     RewriteCond %{REQUEST_FILENAME} !-d
		     RewriteRule . /index.php [L]
        </IfModule>
	     ```

    1. Save the changes: **Ctrl** + **O** and **Enter**. To exit, press **Ctrl** + **X**.

{% endlist %}

Check the website. If the links don't open, it means the support of the `.htaccess` file was disabled in `Apache`.

To enable the support of `.htaccess`:

{% list tabs %}

- Ubuntu

    1. Enter the command:

        ```bash
        sudo nano /etc/apache2/sites-available/000-default.conf
        ```

    1. Add a code:

        ```bash
        <Directory /var/www/html>
		    AllowOverride All
		    Order allow,deny
		    allow from all
        </Directory>
        ``` 

    1. As a result:

        ```bash
        <VirtualHost *:80 [::]:80>
		    ServerAdmin webmaster@localhost
		    DocumentRoot /var/www/html
		    <Directory /var/www/html>
			   AllowOverride All
			   Order allow,deny
			   allow from all
		    </Directory>
		    ErrorLog ${APACHE_LOG_DIR}/error.log
		    CustomLog ${APACHE_LOG_DIR}/access.log combined
        </VirtualHost>
        ```

    1. Restart Apache:

        ```bash
        sudo systemctl restart apache2
        ```

{% endlist %}
