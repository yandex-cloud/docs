# WordPress website on a MySQL database cluster

The following instructions explain how to deploy a website in WordPress CMS on a database cluster running MySQL in the {{ yandex-cloud }} infrastructure.

To set up a WordPress website based on a MySQL cluster:

1. [Before you start](#before-you-begin).
1. [Create a virtual machine for WordPress](#create-vm).
1. [Create a MySQL database cluster](#create-clusters).
1. [Configure Nginx web server](#configure-nginx).
1. [Install WordPress and additional components](#install-wordpress).
1. [Complete WordPress configuration](#configure-wordpress).
1. [Configure the DNS](#configure-dns).
1. [Check that the website is running](#test-site).

If you no longer need the website, [delete all its resources](#clear-out).

You can also deploy the infrastructure for hosting a website in WordPress with a MySQL cluster via {{ TF }} using a [ready-made configuration file](#terraform).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost for supporting your website in WordPress with a MySQL cluster includes:

* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for the MySQL database cluster (see [{{ mmy-full-name }} pricing](../../managed-mysql/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for public DNS queries and zones (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).


## Create a virtual machine for WordPress {#create-vm}

To create a VM:

{% list tabs %}

- Management console

   1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

   2. In the **Name** field, enter a name for the VM: `wp-mysql-tutorial-web`.

   3. Select an [availability zone](../../overview/concepts/geo-scope.md) to put your virtual machine in.

   4. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select [Debian 11](/marketplace/products/yc/debian-11), [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts), or [CentOS 7](/marketplace/products/yc/centos-7) as your public image.

   5. Under **Computing resources**:
      - Choose a [platform](../../compute/concepts/vm-platforms.md).
      - Specify the number of vCPUs and amount of RAM:
         * **vCPU**: 2.
         * **Guaranteed vCPU share**: 20%.
         * **RAM**: 2 GB.

   6. In the **Network settings** section, select the network and subnet to connect the VM to. If you don't have a network or subnet, create them right on the VM creation page.

   7. In the **Public address** field, leave the **Auto** value to assign the virtual machine a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

   8. Specify data required for accessing the VM:
      - In the **Login** field, enter the username, for example, `yc-user`.
      - In the **SSH key** field, paste the contents of the public key file.

         You need to create a key pair for the SSH connection yourself. See the [section about how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

      {% note alert %}

      The IP address and host name (FQDN) to connect to the VM are assigned on VM creation. If you selected **No address** in the **Public address** field, you won't be able to access the VM from the internet.

      {% endnote %}

   9. Click **Create VM**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

Creating the VM may take several minutes. When the VM's status changes to `RUNNING`, you can proceed to the next step.

When the VM is created, it is assigned a public IP address and hostname (FQDN). This data can be used for SSH access.

## Create a MySQL database cluster {#create-cluster}

To create a MySQL database cluster:

{% list tabs %}

- Management console

   1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select the **MySQL cluster**.

   1. In the **Name** field, enter the cluster name: `wp-mysql-tutorial-db-cluster`.

   1. Under **Host class**, select **s2.small**.

   1. Under **Storage size**, enter 10 GB.

   1. Under **Database**, enter:
      - In the **Name** field, enter: `wp-mysql-tutorial-db`.
      - In the **Username** field, enter `wordpress`.
      - In the **Password** field, enter the password you will use to access the DB.

   1. Under **Network settings**:
      - In the **Network** list, select the network your cluster will connect to.

      1. Under **Hosts**, add two more hosts in the other availability zones. When creating hosts, do not enable **Public access** to them.

   1. Under **DBMS settings**, click **Settings**.

      In the **Default authentication plugin** field, select **mysql_native_password** and click **Save**.

   1. Click **Create cluster**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

Creating the DB cluster may take several minutes.

## Configure Nginx web server {#configure-nginx}

After the `wp-mysql-tutorial-web` VM changes its status to `RUNNING`:

1. Go to the VM page of the [management console]({{ link-console-main }}). In the **Network** section, find the VM's public IP address.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` utility in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

   The recommended authentication method when connecting over SSH is using a key pair. Don't forget to set up the created key pair: the private key must match the public key sent to the VM.

1. Install Nginx, PHP-FPM process manager, and additional packages:

   {% list tabs %}

   - Debian/Ubuntu

      ```bash
      sudo apt-get update
      sudo apt-get install -y nginx-full php-fpm php-mysql
      sudo systemctl enable nginx
      ```

   - CentOS

      ```bash
      sudo yum -y install epel-release
      sudo yum -y install nginx
      sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
      sudo yum -y --enablerepo=remi-php74 install php php-mysql php-xml php-soap php-xmlrpc php-mbstring php-json php-gd php-mcrypt
      sudo yum -y --enablerepo=remi-php74 install php-fpm
      sudo systemctl enable nginx
      sudo systemctl enable php-fpm
      ```

   {% endlist %}

1. Use the Nginx configuration files to configure the web server:

   {% list tabs %}

   - Debian/Ubuntu

      1. You can edit files in the `nano` editor:

         ```bash
         sudo nano /etc/nginx/sites-available/wordpress
         ```

      1. Make the file look like:

         ```nginx
         server {
             listen 80 default_server;
         
             root /var/www/wordpress;
             index index.php;
         
             server_name <DNS-server name>;
         
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
                 fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
                 fastcgi_index index.php;
                 fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                 include fastcgi_params;
             }
         }
         ```

      1. Enable launch for your site:

         ```bash
         sudo rm /etc/nginx/sites-enabled/default
         sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
         ```

   - CentOS

      You can edit the files `nginx.conf` and `wordpress.conf` in the `nano` editor:

      1. Open `nginx.conf`:

         ```bash
         sudo nano /etc/nginx/nginx.conf
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
         sudo nano /etc/nginx/conf.d/wordpress.conf
         ```

      1. Make the file look like:

         ```nginx
         server {
             listen 80 default_server;
         
             root /usr/share/nginx/wordpress/;
             index index.php;
         
             server_name <DNS-server name>;
         
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
      wget https://wordpress.org/latest.tar.gz
      tar -xzf latest.tar.gz
      mv wordpress/wp-config-sample.php wordpress/wp-config.php
      sudo mv wordpress /var/www/wordpress
      sudo chown -R www-data:www-data /var/www/wordpress
      ```

   - CentOS

      ```bash
      curl https://wordpress.org/latest.tar.gz --output latest.tar.gz
      tar -xzf latest.tar.gz
      mv wordpress/wp-config-sample.php wordpress/wp-config.php
      sudo mv wordpress /usr/share/nginx/wordpress
      sudo chown -R nginx:nginx /usr/share/nginx/wordpress/
      ```
      Change the SELinux settings:

      ```bash
      sudo semanage fcontext -a -t httpd_sys_content_t "/usr/share/nginx/wordpress(/.*)?"
      sudo semanage fcontext -a -t httpd_sys_rw_content_t "/usr/share/nginx/wordpress(/.*)?"
      sudo restorecon -R /usr/share/nginx/wordpress
      sudo setsebool -P httpd_can_network_connect 1
      ```

   {% endlist %}

1. Get WordPress security keys:

   ```bash
   curl -s https://api.wordpress.org/secret-key/1.1/salt/
   ```

   Save the command output. You will need the keys in the next step.

1. Add the security keys to the WordPress configuration file `wp-config.php`. You can edit files in the `nano` editor:

   {% list tabs %}

   - Debian/Ubuntu

      ```bash
      sudo nano /var/www/wordpress/wp-config.php
      ```

   - CentOS

      ```bash
      sudo nano /usr/share/nginx/wordpress/wp-config.php
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
   - `<DB_NAME>`: DB name, `wp-mysql-tutorial-db`.
   - `<DB_USER>`: `wordpress` username.
   - `<DB_PASSWORD>`: password you set when [creating a DB cluster](#create-cluster).
   - `<DB_HOST>`: MySQL host name in `XXXX-XXXXXXXXXX.{{ dns-zone }}` format.

      To find out the FQDN of your MySQL host:

      {% list tabs %}

      - Management console

         1. Go to the MySQL cluster page.
         1. In the **Databases** tab, click ![image](../../_assets/options.svg).
         1. Select **Connect**.
         1. Locate the line `mysql --host=XXXX-XXXXXXXXXX.{{ dns-zone }}`, where `XXXX-XXXXXXXXXX.{{ dns-zone }}` is the FQDN of the `MASTER` host.

      - CLI

         [Get a host list](../../managed-mysql/operations/hosts.md#list) and copy the `NAME` of the `MASTER` host:
         ```
         	yc managed-mysql host list --cluster-name <MySQL cluster name>
         ```

         
         ```text
         	+-----------------------------+----------------------+---------+--------+---------------+-----------+ 
         	|             NAME            |      CLUSTER ID      |  ROLE   | HEALTH |    ZONE ID    | PUBLIC IP | 
         	+-----------------------------+----------------------+---------+--------+---------------+-----------+ 
         	| rc1a-...{{ dns-zone }} | c9quhb1l32unm1sdn0in | MASTER  | ALIVE  | {{ region-id }}-a | false     | 
         	| rc1b-...{{ dns-zone }} | c9quhb1l32unm1sdn0in | REPLICA | ALIVE  | {{ region-id }}-b | false     | 
         	+-----------------------------+----------------------+---------+--------+---------------+-----------+ 
         ```


      {% endlist %}

3. Restart Nginx and PHP-FPM:

   {% list tabs %}

   - Debian/Ubuntu

      ```bash
      sudo systemctl restart nginx.service 
      sudo systemctl restart php7.4-fpm.service
      ```

   - CentOS

      ```bash
      sudo systemctl restart nginx.service 
      sudo systemctl restart php-fpm.service
      ```

   {% endlist %}

## Complete WordPress configuration {#configure-wordpress}

1. Go to the VM page of the [management console]({{ link-console-main }}). In the **Network** section, find the VM's public IP address.

1. Open the VM by entering its address in your browser.

1. Select the language and click **Continue**.

1. Fill out information to access the website:

   * Enter any website name, for example, `wp-your-project`.
   * Specify the username to be used to log in to the admin panel (for example, `admin`).
   * Enter the password to be used to log in to the admin panel.
   * Enter your email address.

1. Click **Install WordPress**.

1. If the installation is successful, click **Log in**.

1. Log in to the website with the username and password specified in the previous steps. This opens the admin panel, where you can start working with your website.

## Configure the DNS {#configure-dns}

If you have a registered domain name, use the {{ dns-name }} service to manage the domain.

You can also configure the DNS via {{ TF }}. For more information, see [How to create an infrastructure using {{ TF }}](#terraform).

{% include [configure-a-record-and-cname](../../_tutorials/web/configure-a-record-and-cname.md) %}

## Check that the website is running {#test-site}

To check that the site is up, enter its IP address or domain name in your browser:
* `http://<public_IP_of_VM>`.
* `http://www.example.com`.

To access the WordPress control panel, use `http://www.example.com/wp-admin/`.

## How to delete created resources {#clear-out}

To stop paying for the deployed website:

1. [Delete a DNS zone](../../dns/operations/zone-delete.md).
1. [Delete a MySQL cluster](../../managed-mysql/operations/cluster-delete.md).
1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).

If you reserved a static public IP address for the VM, [delete it](../../vpc/operations/address-delete.md).

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

To host a WordPress website based on a MySQL cluster via {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   This tutorial uses [security groups](../../vpc/concepts/security-groups.md). If you don't have access to them, write to support or remove from the configuration file the `yandex_vpc_security_group` section and other mentions of `security_group`.

   {% list tabs %}

   - Ready-made archive

      1. Create a directory for files:
      1. Download the [archive](https://{{ s3-storage-host }}/www.example.com/doc-files/wordpress-mysql.zip) (1 KB).
      1. Unpack the archive to the directory. The `wordpress-mysql.tf` file should be added to the directory.

   - Creating files manually

      1. Create a directory for files:
      1. Create the `wordpress.tf` configuration file in the directory:

         {% cut "wordpress-mysql.tf" %}

         {% include [wordpress-mysql-tf-config](../../_includes/web/wordpress-mysql-tf-config.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
   * [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster)
   * [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database)
   * [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user)
   * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
   * [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. Under `metadata`, enter the metadata for creating a VM instance: `<username>:<SSH_key_contents>`. Regardless of the username specified, the key is assigned to the user set in the image configuration. In different images, these users differ. For more information, see [{#T}](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).

1. Under `boot_disk`, specify the ID of a VM [image](../../compute/operations/images-with-pre-installed-software/get-list.md) with a relevant set of components:

   * [Debian 11](/marketplace/products/yc/debian-11).
   * [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
   * [CentOS 7](/marketplace/products/yc/centos-7).

1. Create resources:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Check that the website is running](#test-site).
