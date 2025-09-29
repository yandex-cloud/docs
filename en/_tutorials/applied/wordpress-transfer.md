# Transferring a WordPress website from a different hosting provider to {{ yandex-cloud }}

[WordPress](https://wordpress.com) is an open-source content management system.

With WordPress, you can create news sites, personal or corporate blogs, business websites, online stores, and other services.

It allows you to launch your website with minimal effort using one of the many available templates or your own design. Ready-made plugins help you easily add new blocks or features to a created service.

In {{ yandex-cloud }}, you can quickly [create a website on WordPress](../../tutorials/web/wordpress/index.md) or transfer from another hosting provider.

To transfer a WordPress website to {{ yandex-cloud }}:
1. [Make a backup of the site](#create-backup)
1. [Get your cloud ready](#before-begin).
1. [Create a virtual machine for WordPress](#create-vm).
1. [Connect to the VM](#connect-vm).
1. [Install and configure additional components](#additional-components).
1. [Import the database](#import-db).
1. [Transfer the site files](#transfer-files).
1. [Configure DNS](#configure-dns).
1. [Create a SSL certificate](#setting-ssl).
1. [Test the website](#check-site).

## Make a backup of the site {#create-backup}

Create a backup of the website and DB files using one of the following methods:
* Using various WordPress plugins, e.g., [BackWPup](https://wordpress.org/plugins/backwpup) or [Updraft Plus](https://wordpress.org/plugins/updraftplus).
* Using built-in tools from the hosting control panel for your website.
* Copying all the files to your hard drive using an FTP client and exporting the DB using [phpMyAdmin](https://www.phpmyadmin.net/).

  This method is longer and will take 5 to 20 minutes because you need to copy numerous small files that make up your site.

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Make sure the selected [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) has a [cloud network](../../vpc/concepts/network.md#network) with a [subnet](../../vpc/concepts/network.md#subnet) in at least one [availability zone](../../overview/concepts/geo-scope.md). To do this, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** on the folder page. If the list contains a network, click its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

### Required paid resources {#paid-resources}

The cost of maintaining a WordPress website includes:
* Fee for a continuously running [VM](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for public DNS queries and [zones](../../dns/concepts/dns-zone.md) (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).

## Create a VM for WordPress {#create-vm}

To create a VM:
1. On the [folder dashboard](../../resource-manager/concepts/resources-hierarchy.md#folder) of the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `LAMP` and select the [LAMP](/marketplace/products/yc/lamp) public image containing the required components: Linux, Apache web server, {{ MY }} DBMS, and PHP interpreter.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) your VM will reside in. If you are not sure which one to choose, leave the default.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select the [disk type](../../compute/concepts/disk.md#disks_types) and set the required size.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and RAM size:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`

1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

   * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is not there, [create it](../../vpc/operations/subnet-create.md).
   * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, leave `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign a random external IP address to your VM from the {{ yandex-cloud }} pool. Alternatively, select a static address from the list if you reserved one.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

   * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username. Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.
   * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `wordpress-vm`.

    {% note alert %}

    Once created, the VM gets an IP address and a [host name (FQDN)](../../compute/concepts/network.md#hostname) for connections. If you selected `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` in the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, you will not be able to access the VM from the internet.

    {% endnote %}

1. Under **{{ ui-key.yacloud.compute.instances.create.field_access-advanced }}**, select a [service account](../../iam/concepts/users/service-accounts.md) or create a new one.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   It may take a few minutes to create your VM. When the VM [status](../../compute/concepts/vm-statuses.md) changes to `RUNNING`, you can [upload the website files](#upload-files).

## Connect to the VM {#connect-vm}

You can connect to a VM over SSH once it gets the `RUNNING` status. To do this, you can use the `ssh` utility in Linux/macOS/Windows 10 and [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows 7/8.

To connect to the VM, specify its public IP address.

To copy the VM's public IP address:
1. Open the folder page in the [management console]({{ link-console-main }}).
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Find the created VM and click its name.
1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, copy the IP address from the **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** field.

[Connect to the VM](../../compute/operations/vm-connect/ssh.md).

## Install and configure additional components {#additional-components}

Before you transfer your files, do the following:
* Install the `nano` text editor. You will need it to edit some of the configuration files.
* Install and configure `phpMyAdmin` to manage the website DB.

### Install the nano editor {#install-nano}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  Run this command:

  ```bash
  sudo apt install nano
  ```

  Wait for the editor to be installed.

{% endlist %}

### Install phpMyAdmin {#install-phpmyadmin}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Run the following commands:

     ```bash
	 sudo apt-get update
	 sudo apt-get install phpmyadmin php-mbstring php-gettext
	 ```

  1. During the installation process, select the server to install `phpMyAdmin` on. Select `Apache2` and press the **space** bar on the keyboard: the `*` icon will appear next to `Apache2`. Press **Enter**.
  1. Set up `phpMyAdmin` access to the DB. When prompted `Configure database for phpmyadmin with dbconfig-common?`, choose `<yes>`. You can skip entering the password, the system will automatically generate it. To copy the generated password, run the command:

     ```bash
	 sudo cat /root/default_passwords.txt
	 ```

	 The text of the file must contain the following data:

	 ```text
	 MYSQL_ROOT_PASS=KjZKrQV7efFGk
	 ```

	 Copy and save the password: `MYSQL_ROOT_PASS`. You will need it later.
  1. Enable the `mbstring` extension for PHP:

     ```bash
	 sudo phpenmod mbstring
	 ```

  1. To accept all changes, restart Apache:

     ```bash
	 sudo systemctl restart apache2
	 ```

  1. Open `phpMyAdmin` in the browser. In the address bar, enter `http://<VM_public_IP_address>/phpmyadmin`.

	 To log in to `phpMyAdmin`, use the following data:

	 ```text
	 User: root
	 Password: system-generated (MYSQL_ROOT_PASS from the default_passwords.txt file)
	 ```

{% endlist %}

### Configure phpMyAdmin {#setting-phpmyadmin}

Set up an additional password to log in to the `phpMyAdmin` panel. Edit the `phpmyadmin.conf` file to enable the use of access settings in `.htaccess`.

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Run this command:

     ```bash
	 sudo nano /etc/apache2/conf-available/phpmyadmin.conf
	 ```

  1. Add the `AllowOverride All` line to the `phpmyadmin.conf` file:

     ```text
	 <Directory /usr/share/phpmyadmin>
	 Options SymLinksIfOwnerMatch
	 DirectoryIndex index.php
	 AllowOverride All
	 ```

  1. Save the changes to the `phpmyadmin.conf` file. To do this, press **Ctrl** + **O** and **Enter**. To exit the file, press **Ctrl** + **X**.
  1. Restart Apache:

     ```bash
	 sudo systemctl restart apache2
	 ```

  1. Create `.htaccess`:

     ```bash
	 sudo nano /usr/share/phpmyadmin/.htaccess
	 ```

  1. Copy these lines to `.htaccess`:

     ```text
	 AuthType Basic
	 AuthName "Restricted Files"
	 AuthUserFile /etc/phpmyadmin/.htpasswd
	 Require valid-user
	 ```

  1. Save the changes to the file.
  1. Create `.htpasswd`:

     ```bash
	 sudo htpasswd -c /etc/phpmyadmin/.htpasswd <username>
	 ```

	 Set the desired password and repeat it.
  1. Restart Apache:

     ```bash
	 sudo systemctl restart apache2
	 ```

  Now, when logging in to phpMyAdmin, you will need to enter an additional username and password specified in the `.htpasswd` file.

{% endlist %}

## Import the DB {#import-db}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Open your website’s WordPress configuration file. To do this, unpack the archive and open the `wp-config.php` file in the root folder. Find the values of the `DB_USER`, `DB_NAME`, and `DB_PASSWORD` parameters:

     ```bash
	 define('DB_USER', 'UsernameTEST');
	 define('DB_NAME', 'database_wordpress');
	 define('DB_PASSWORD', 'MySecretPassword');
	 ```

  1. Log in to phpMyAdmin — enter the following in the browser address bar:

     ```http request
     http://<VM_public_IP_address>/phpmyadmin`
     ```

  1. Go to the **User accounts** section and add a user account with the following parameters:
     * **Username**: Insert a value for `DB_USER` from `wp-config.php`.
     * **Host name**: Leave the default value, `%`.
     * **Password**: Insert a value for `DB_PASSWORD` from `wp-config.php`.
     * **Global privileges**: Enable the **Mark all** option.

     Leave the other default parameters when creating a user. At the bottom of the screen, click **Forward**.
  1. Go to the **Databases** section. Fill in the **Database name** field with a value for `DB_NAME` from `wp-config.php`. Select the `utf8_general_ci` encoding. Click **Create**.
  1. Import the DB from a backup:
     * In the left column, select the DB you created.
     * Click **Import** and select the saved DB backup. If the DB backup exceeds the default limit of 2 MB, edit the `php.ini` configuration file where this limit is set.
     1. Run this command:

	    ```bash
	    sudo nano /etc/php/X.X/apache2/php.ini
	    ```

	    `X.X`: PHP version. Possible values: `5.6`, `7.0`, `7.1`, `7.2`, `7.3`, `7.4`, `8.0`, `8.1`.
	 1. Edit the parameters:
	    * `upload_max_filesize`: Maximum size of the uploaded file.
	    * `post_max_size`: Maximum message size for the `POST` method.

	    ```bash
	    upload_max_filesize = 80M
	    post_max_size = 80M
	    ```

	 1. Save the changes: Press **Ctrl**+**O** and **Enter**. To exit the file, press **Ctrl**+**X**.
	 1. Restart Apache:

	    ```bash
	    sudo systemctl restart apache2
	    ```

	 1. Repeat the DB import operation.

{% endlist %}

### Disable phpMyAdmin {#disable-phpmyadmin}

All the main DB migration activities are performed. Disable the utility to avoid outside attacks on `phpMyAdmin`:

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  ```bash
  sudo a2disconf phpmyadmin.conf && sudo /etc/init.d/apache2 restart
  ```

{% endlist %}

You can use the terminal to work with the DB.

## Transfer the site files {#transfer-files}

To transfer backup files to a VM, use the [FileZilla](https://filezilla-project.org/) FTP client:
1. Open FileZilla.
1. Go to **File** → **Site manager** and add a new website.
1. Select SFTP and enter the VM's public IP address. Under **Logon type**, select **File with the key**.
1. Specify the user created when configuring the VM and select the key file (located in the `/Users/<username>/.ssh/` folder).

   The FTP client does not see the hidden folder by default. Press **Cmd** + **Shift** + **G** and select the `id_ed25519` file without the `pub` extension. A message is displayed that the file is not supported. The FTP client will offer to convert it to the desired format. Click **Yes**. Save the converted file in a convenient location.
1. Click **Connect** and enter the passphrase that you created at the beginning of the work. As a result, you will connect to the VM.
1. Find the `/var/www/html` folder on the VM and paste the backup file there. You do not need to copy index.html.

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     By default, 755 rights are set for this folder. To copy the site archive file from your hard drive to the `html` folder, change the permissions for the folder:

     ```bash
     sudo chmod 777 /var/www/html
     ```

     Unpack the backup:

     ```bash
     cd /var/www/html
     tar -xvf FILENAME.tar.gz
     ```

     Instead of `FILENAME`, specify the name of the site archive file.

     {% note alert %}

     You should unpack all the files to the `html` root directory, not to the `/var/www/html/wordpress` subdirectory.

     {% endnote %}

	 Delete the backup file so that it does not take up space:

     ```bash
     rm FILENAME.tar.gz
     ```

     Return the rights for the folders:
     * `html` and subfolders: `755`.
     * For all files inside `html`: `644`.
     * For `wp-config.php` separately, access level: `600`.

     ```bash
     cd var/www/
     sudo find ./ -type d -exec chmod 0755 {} \;
     sudo find ./ -type f -exec chmod 0644 {} \;
     sudo chmod 600 wp-config.php
     ```

     `f` parameter: Searches for all files within folders. `d` parameter: Searches for all folders within `html`.

   {% endlist %}

## Configure DNS {#configure-dns}

Use {{ dns-name }} to manage the domain.

{% include [configure-a-record-and-cname](../_tutorials_includes/configure-a-record-and-cname.md) %}

### Test the website {#test-site}

To test the site, enter its IP address or domain name in your browser:
* `http://<VM_public_IP_address>`.
* `http://www.example.com`.

## Install the SSL certificate using Let's Encrypt® {#setting-ssl}

Use [Let’s Encrypt](https://letsencrypt.org/) to install the [certificate](../../certificate-manager/concepts/managed-certificate.md). Let's Encrypt is a certificate authority that issues free [SSL certificates](https://wikipedia.org/wiki/SSL).

### Install the Let's Encrypt client {#install-client}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Enter the following command in the terminal:

     ```bash
	 sudo apt-get update && sudo apt-get install software-properties-common
	 ```

  1. Add the `universe` and `certbot` repositories:

     ```bash
     sudo add-apt-repository universe && sudo add-apt-repository ppa:certbot/certbot
     ```

     Press **Enter**.
  1. Install the Let's Encrypt client:

     ```bash
     sudo apt-get update && sudo apt-get install certbot python-certbot-apache
     ```

  1. Press **Y** and **Enter**.

{% endlist %}

### Get an SSL certificate{#get-ssl}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Enter this command:

     ```bash
     sudo certbot --apache
     ```

  1. In the interface, enter the name of your domain: `example.com` or `www.example.com`.
  1. Indicate whether to redirect all pages from `http` to `https` when opening your website. Select `2` to redirect to https.
  1. Test your website: paste `https://www.ssllabs.com/ssltest/analyze.html?d=example.com` to your browser's address bar.

{% endlist %}

### Perform auto-update {#self-update}

The certificate is issued for 90 days. You need to update it regularly. Configure the update schedule using `cron`:

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

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

## Test the website {#check-site}

WordPress sites sometimes have a problem opening internal links when switching from one hosting to another. Check whether the `.htaccess` file exists in your website's root folder `var/www/html/.htaccess`.

If there is no file, create it.

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Enter the following command in the terminal:

     ```bash
	 sudo nano /var/www/html/.htaccess
	 ```

  1. Add program code:

     ```html
	 <IfModule mod_rewrite.c>
	   RewriteEngine On
	   RewriteBase /
	   RewriteRule ^index\.php$ - [L]
	   RewriteCond %{REQUEST_FILENAME} !-f
	   RewriteCond %{REQUEST_FILENAME} !-d
	   RewriteRule . /index.php [L]
	 </IfModule>
	 ```

  1. Save the changes: **Ctrl**+**O** and **Enter**. To exit, press **Ctrl**+**X**.

{% endlist %}

Test the website. If the links do not open, it means that support for the `.htaccess` file is disabled in `Apache`.

To enable `.htaccess` support:

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

  1. Enter this command:

     ```bash
	 sudo nano /etc/apache2/sites-available/000-default.conf
	 ```

  1. Add program code:

     ```text
	 <Directory /var/www/html>
	   AllowOverride All
	   Order allow,deny
	   allow from all
	 </Directory>
	 ```

  1. As a result:

     ```html
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