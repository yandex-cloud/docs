# WordPress website on a MySQL database cluster

The following instructions explain how to deploy a website in WordPress CMS on a database cluster running MySQL in the {{ yandex-cloud }} infrastructure.

To set up a WordPress website based on a MySQL cluster:

1. [Before you start](#before-you-begin).
1. [Create a VM for WordPress](#create-vm).
1. [Create a MySQL database cluster](#create-clusters).
1. [Configure Nginx web server](#configure-nginx).
1. [Install WordPress and additional components](#install-wordpress).
1. [Set up WordPress](#configure-wordpress).
1. [Check that the website is running](#test-site).
1. [Configure DNS](#configure-dns).

If you no longer need the website, [delete all its resources](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost for supporting your website in WordPress with a MySQL cluster includes:

* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for the MySQL database cluster (see [pricing {{ mmy-full-name }}](../../managed-mysql/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

{% endif %}

## Create a virtual machine for WordPress {#create-vm}

To create a VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

2. In the **Name** field, enter a name for the VM: `wp-mysql-tutorial-web`.

3. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

4. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the public image of [Debian 11](/marketplace/products/yc/debian-11), [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts), or [CentOS 7](/marketplace/products/yc/centos-7).

5. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md).
    - Specify the number of vCPUs and amount of RAM:
       * **vCPU**: 2.
       * **Guaranteed vCPU share**: 5%.
       * **RAM**: 1 GB.

6. In the **Network settings** section, select the network and subnet to connect the VM to. If you don't have a network or subnet, create them right on the VM creation page.

7. In the **Public address** field, leave the **Auto** value to assign a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

8. Specify data required for accessing the VM:

    - Enter the username in the **Login** field.

    - In the **SSH key** field, paste the contents of the public key file.

      You need to create a key pair for the SSH connection yourself. Learn [how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

    {% note alert %}

     The IP address and host name (FQDN) to connect to the VM are assigned on VM creation. If you selected **No address** in the **Public address** field, you won't be able to access the VM from the internet.

    {% endnote %}

9. Click **Create VM**.

Creating the VM may take several minutes. When the VM's status changes to `RUNNING`, you can proceed to the next step.

When the VM is created, it is assigned a public IP address and hostname (FQDN). This data can be used for SSH access.

## Create a MySQL database cluster {#create-cluster}

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **MySQL Cluster**.

1. In the **Name** field, enter the cluster name: `wp-mysql-tutorial-db-cluster`.

1. Under **Host class**, select **s2.small**.

1. Under **Storage size**, enter 10 GB.

1. Under **Database**, enter:
    - In the **Name** field, enter: `wp-mysql-tutorial-db`.
    - In the **Username** field, enter `wordpress`.
    - In the **Password** field, enter the password you will use to access the DB.
    - In the **Network** list, select the network your VM will connect to.

{% if product == "yandex-cloud" %}
1. Under **Hosts**, add two more hosts in the other availability zones. When creating hosts, do not enable **Public access** to them.
{% endif %}

1. Under **DBMS settings**, click **Settings**.

   In the **Default authentication plugin** field, select **mysql_native_password** and click **Save**.

1. Click **Create cluster**.

Creating the DB cluster may take several minutes.

## Configure Nginx web server {#configure-nginx}

After the `wp-mysql-tutorial-web` VM changes its status to `RUNNING`:

1. You can learn the IP address of the VM under **Network** on the VM page in the [management console]({{ link-console-main }}).

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` tool in Linux and macOS or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows.

   The recommended authentication method when connecting over SSH is using a key pair. Don't forget to set up the created key pair: the private key must match the public key sent to the VM.

1. Install Nginx, PHP-FPM process manager, and additional packages:

   {% list tabs %}

   - Debian/Ubuntu

     ```bash
     $ sudo apt-get update -qq
     $ sudo apt-get install -y nginx-full php-fpm php-mysql
     $ sudo systemctl enable nginx
     ```

   - CentOS

     ```bash
     $ sudo yum -y install epel-release
     $ sudo yum -y install nginx
     $ sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
     $ sudo yum -y --enablerepo=remi-php72 install php php-mysql php-xml php-soap php-xmlrpc php-mbstring php-json php-gd php-mcrypt
     $ sudo yum -y --enablerepo=remi-php72 install php-fpm
     $ sudo systemctl enable nginx
     $ sudo systemctl enable php-fpm
     ```

   {% endlist %}

1. Use the Nginx configuration files to configure the web server:

   {% list tabs %}

   - Debian

     1. You can edit the file in the `nano` editor:

         ```bash
         $ sudo nano /etc/nginx/sites-available/wordpress
         ```

     1. Make the file look like:

         ```nginx
         server {
             listen 80 default_server;
         
             root /var/www/wordpress;
             index index.php;
         
             server_name <DNS server name>
         
             location / {
                 try_files $uri $uri/ =404;
             }
         
             error_page 404 /404.html;
             error_page 500 502 503 504 /50x.html;
             location = /50x.html {
                 root /usr/share/nginx/html;
             }
         
             location ~ \.php$ {
                 try_files $uri =404;
                 fastcgi_split_path_info ^(.+\.php)(/.+)$;
                 fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
                 fastcgi_index index.php;
                 fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                 include fastcgi_params;
             }
         }
         ```

     1. Enable launch for your site:

         ```bash
         $ sudo rm /etc/nginx/sites-enabled/default
         $ sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
         ```

   - Ubuntu

     1. You can edit the file in the `nano` editor:

         ```bash
         $ sudo nano /etc/nginx/sites-available/wordpress
         ```

     1. Make the file look like:

         ```nginx
         server {
             listen 80 default_server;
         
             root /var/www/wordpress;
             index index.php;
         
             server_name <DNS server name>
         
             location / {
                 try_files $uri $uri/ =404;
             }
         
             error_page 404 /404.html;
             error_page 500 502 503 504 /50x.html;
             location = /50x.html {
                 root /usr/share/nginx/html;
             }
         
             location ~ \.php$ {
                 try_files $uri =404;
                 fastcgi_split_path_info ^(.+\.php)(/.+)$;
                 fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
                 fastcgi_index index.php;
                 fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                 include fastcgi_params;
             }
         }
         ```

     1. Enable launch for your site:

         ```bash
         $ sudo rm /etc/nginx/sites-enabled/default
         $ sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
         ```

   - CentOS

     You can edit the files `nginx.conf` and `wordpress.conf` in the `nano` editor:

     1. Open `nginx.conf`:

         ```bash
         $ sudo nano /etc/nginx/nginx.conf
         ```

     1. Make the file look like:

         ```nginx
         user nginx;
         worker_processes auto;
         error_log /var/log/nginx/error.log;
         pid /run/nginx.pid;
         include /usr/share/nginx/modules/*.conf;
         
         events {
             worker_connections 1024;
         }
         
         http {
             log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                               '$status $body_bytes_sent "$http_referer" '
                               '"$http_user_agent" "$http_x_forwarded_for"';
         
             access_log  /var/log/nginx/access.log  main;
         
             sendfile            on;
             tcp_nopush          on;
             tcp_nodelay         on;
             keepalive_timeout   65;
             types_hash_max_size 2048;
         
             include             /etc/nginx/mime.types;
             default_type        application/octet-stream;
         
             include /etc/nginx/conf.d/*.conf;
         }
         ```

     1. Open `wordpress.conf`:

         ```bash
         $ sudo nano /etc/nginx/wordpress.conf
         ```

     1. Make the file look like:

         ```nginx
         server {
             listen 80 default_server;
         
             root /usr/share/nginx/wordpress/;
             index index.php;
         
             server_name <DNS server name>
         
             location / {
                 try_files $uri $uri/ =404;
             }
         
             error_page 404 /404.html;
             error_page 500 502 503 504 /50x.html;
             location = /50x.html {
                 root /usr/share/nginx/html;
             }
         
             location ~ \.php$ {
                 try_files $uri =404;
                 fastcgi_split_path_info ^(.+\.php)(/.+)$;
                 fastcgi_pass 127.0.0.1:9000;
                 fastcgi_index index.php;
                 fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                 include fastcgi_params;
             }
         }
         ```

   {% endlist %}

## Install WordPress and additional components {#install-wordpress}

1. Download and unpack the latest WordPress version:

   {% list tabs %}

   - Debian/Ubuntu

     ```bash
     $ wget https://wordpress.org/latest.tar.gz
     $ tar -xzf latest.tar.gz
     $ mv wordpress/wp-config-sample.php wordpress/wp-config.php
     $ sudo mv wordpress /var/www/wordpress
     $ sudo chown -R www-data:www-data /var/www/wordpress
     ```

   - CentOS

     ```bash
     $ curl https://wordpress.org/latest.tar.gz --output latest.tar.gz
     $ tar -xzf latest.tar.gz
     $ mv wordpress/wp-config-sample.php wordpress/wp-config.php
     $ sudo mv wordpress /usr/share/nginx/wordpress
     $ sudo chown -R nginx:nginx /usr/share/nginx/wordpress/
     ```

     Change the SELinux settings:

     ```bash
     $ sudo semanage fcontext -a -t httpd_sys_content_t "/usr/share/nginx/wordpress(/.*)?"
     $ sudo semanage fcontext -a -t httpd_sys_rw_content_t "/usr/share/nginx/wordpress(/.*)?"
     $ sudo restorecon -R /usr/share/nginx/wordpress
     $ sudo setsebool -P httpd_can_network_connect 1
     ```

   {% endlist %}

1. Get WordPress security keys:

   ```bash
   $ curl -s https://api.wordpress.org/secret-key/1.1/salt/
   ```

   Save the command output. You will need the keys in the next step.

1. Add the security keys to the WordPress configuration file `wp-config.php`. You can edit files in the `nano` editor:

   {% list tabs %}

   - Debian/Ubuntu

     ```bash
     $ sudo nano /var/www/wordpress/wp-config.php
     ```

   - CentOS

     ```bash
     $ sudo nano /usr/share/nginx/wordpress/wp-config.php
     ```

   {% endlist %}

   Replace the configuration section for the values from the previous step:

   ```php
   define('AUTH_KEY',         't vz,|............R lZ5]');
   define('SECURE_AUTH_KEY',  '@r&pPD............dK-A%=');
   define('LOGGED_IN_KEY',    '%6TuLl............9>/dNE');
   define('NONCE_KEY',        'DO(u.H............$?ja-e');
   define('AUTH_SALT',        '|G Vo<............Xeb.~y');
   define('SECURE_AUTH_SALT', 'Y5tIYA............7Lxf8J');
   define('LOGGED_IN_SALT',   'gR]>WZ............<>|;YY');
   define('NONCE_SALT',       '=]nQIb............HLT2:9');
   ```

2. Go to the cluster connection configuration section `wp-mysql-tutorial-db-cluster`:

   ```php
   // ** MySQL settings - You can get this info from your web host ** //
   /** The name of the database for WordPress */
   
   define( 'DB_NAME', '<DB_NAME>' );
   /** MySQL database username */
   define( 'DB_USER', '<DB_USER>' );
   
   /** MySQL database password */
   define( 'DB_PASSWORD', '<DB_PASSWORD>' );
   
   /** MySQL hostname */
   define( 'DB_HOST', '<DB_HOST>' );
   ```

   Replace the placeholders in the file:
   - `<DB_NAME>` — with the DB name, `wp-mysql-tutorial-db`.
   - `<DB_USER>` — with the `wordpress` username.
   - `<DB_PASSWORD>` — with the password specified when [creating a DB cluster](#create-cluster).
   - `<DB_HOST>` — with the host in the format `c-<master ID>.rw.{{ dns-zone }}`. To find out the master ID, [get the list of hosts](../../managed-mysql/operations/hosts.md#list) via the CLI and copy `CLUSTER ID` with the `MASTER` role.

3. Restart Nginx and PHP-FPM:

   {% list tabs %}

   - Debian

     ```bash
     $ sudo systemctl restart nginx.service 
     $ sudo systemctl restart php7.3-fpm.service
     ```

   - Ubuntu

     ```bash
     $ sudo systemctl restart nginx.service 
     $ sudo systemctl restart php7.2-fpm.service
     ```

   - CentOS

     ```bash
     $ sudo systemctl restart nginx.service 
     $ sudo systemctl restart php-fpm.service
     ```

   {% endlist %}

## Configure WordPress {#configure-wordpress}

1. You can learn the IP address of the VM under **Network** on the VM page in the [management console]({{ link-console-main }}).

1. Open the VM by entering its address in your browser.

1. Select the language and click **Continue**.

1. Fill out information to access the website:

   - Enter any name for the website (for example, `yc-wordpress`).

   - Specify the username to be used to log in to the admin panel (for example, `yc-user`).

   - Enter the password to be used to log in to the admin panel.

   - Enter your email address.

1. Click **Install WordPress**.

1. If the installation is successful, click **Log in**.

1. Log in to the website with the username and password specified in the previous steps. This opens the admin panel, where you can start working with your website.

## Check that the website is running {#test-site}

To check that the website is running, visit the public IP address of the VM in the browser.

## Configure DNS (if you have a domain name) {#configure-dns}

To link the website to your domain, configure DNS at your registrar as follows:

* A record: `@` subdomain (use the VM's public IP address as the address).
* CNAME record: `www` subdomain (use a domain with a dot at the end as the canonical name, like `example.com).`

## How to delete created resources {#clear-out}

To stop paying for your deployed website, just delete the [VM](../../compute/operations/vm-control/vm-delete.md) `wp-mysql-tutorial-web` and [MySQL cluster](../../managed-mysql/operations/cluster-delete.md) `wp-mysql-tutorial-db-cluster`.

If you reserved a static public IP address specifically for this VM:

1. Open the **Virtual Private Cloud** in your folder.
1. Go to the **IP addresses** tab.
1. Find the address you need, click ![ellipsis](../../_assets/options.svg), and select **Delete**.
