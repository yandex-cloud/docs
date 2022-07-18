# Joomla-based website with PostgreSQL

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

In these instructions, you'll learn how to deploy a website in Joomla CMS on a database running PostgreSQL in the {{ yandex-cloud }} infrastructure.

To set up a static website on Joomla:
1. [Create a VM for Joomla](#create-vm).
1. [Create a PostgreSQL DB cluster](#create-cluster).
1. [Install Joomla and additional components](#install).
1. [Configure the Apache2 web server](#configure-apache2).
1. [Configure Joomla](#configure-joomla).
1. [Upload the website files](#upload-files).
1. [Configure DNS](#configure-dns).
1. [Check that the website is running](#test-site).

If you no longer need the website, [delete all its resources](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Make sure that the selected folder contains a network with subnets in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-c` availability zones. To do this, select **{{ vpc-name }}** on the folder page. If the list contains a network, click on its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of hosting a website in Joomla includes:
* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for the PostgreSQL database cluster (see [pricing for {{ mpg-full-name }}](../../managed-postgresql/pricing.md)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

{% endif %}

## Create a VM for Joomla {#create-vm}

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name: `joomla-pg-tutorial-web`.

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the [CentOS Stream](/marketplace/products/yc/centos-stream-8) public image.

1. Under **Computing resources**:
   * Choose a [platform](../../compute/concepts/vm-platforms.md).
   * Specify the necessary number of vCPUs and amount of RAM.

   The minimum configuration is enough for functional testing:
   * **Platform**: Intel Ice Lake.
   * **Guaranteed vCPU share**: 20%.
   * **vCPU**: 2.
   * **RAM**: 1 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM:
   * Enter the username in the **Login** field.
   * In the **SSH key** field, paste the contents of the public key file.

    You need to create a key pair for an SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

Creating the VM may take several minutes.

When a VM is created, it is assigned an IP address and hostname (FQDN). This data can be used for SSH access.

## Create a PostgreSQL database cluster {#create-cluster}

1. On the folder page, click **Create resource** and select **PostgreSQL cluster**.
1. In the **Name** field, enter the cluster name: `joomla-pg-tutorial-db-cluster`.
1. In the **DB class** section, select **b2.medium**.
1. In the **Storage size** section, enter 10 GB.
1. In the **Database** section, specify:
   * **DB name**: `joomla-pg-tutorial-db`.
   * **Username**: `joomla`.
   * **Password**: The password you'll use to access the database.
1. In the **Network** list, select the network your VM is connected to.
1. In the **Hosts** section, add two more hosts in the other availability zones. When creating hosts, do not enable **Public access** to them.
1. Click **Create cluster**.

Creating the DB cluster may take several minutes.

## Install Joomla and additional components {#install}

After the `joomla-pg-tutorial-web` VM's status changes to `RUNNING`, do the following:

1. You can learn the IP address of the VM under **Network** on the VM page in the [management console]({{ link-console-main }}).

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` tool in Linux and macOS or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows.

   The recommended authentication method when connecting over SSH is using a key pair. Don't forget to set up the created key pair: the private key must match the public key sent to the VM.

1. Download and unpack the Joomla archive:

   ```bash
   sudo mkdir -p /var/www/html/
   curl https://downloads.joomla.org/cms/joomla3/3-8-7/Joomla_3-8-7-Stable-Full_Package.tar.gz?format=gz -o Joomla_3-8-7-Stable-Full_Package.tar.gz -L
   sudo mv Joomla_3-8-7-Stable-Full_Package.tar.gz /var/www/html/
   (cd /var/www/html/ && sudo tar -zxvf Joomla_3-8-7-Stable-Full_Package.tar.gz)
   sudo rm /var/www/html/Joomla_3-8-7-Stable-Full_Package.tar.gz
   sudo mv /var/www/html/htaccess.txt /var/www/html/.htaccess
   ```

1. Install additional components:

   {% list tabs %}

   - Ubuntu 14

     ```bash
     echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
     wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
     sudo apt-get update
     sudo apt-get -q -y install php5-pgsql php5-curl php5-json php5-cgi php5 libapache2-mod-php5 php5-mcrypt apache2 php5-common cron debconf-utils sendmail unzip iptables postgresql-client-10
     sudo mkdir ~www-data/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~www-data/.postgresql/root.crt
     sudo chmod 0600 ~www-data/.postgresql/root.crt
     sudo chown -R www-data:www-data ~www-data/.postgresql
     ```

   - Ubuntu 16

     ```bash
     echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
     wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
     sudo apt-get update
     sudo apt-get -q -y install php7.0-pgsql php7.0-curl php7.0-json php7.0-cgi php7.0 libapache2-mod-php7.0 php7.0-mcrypt apache2 php-mail php7.0-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
     sudo mkdir ~www-data/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~www-data/.postgresql/root.crt
     sudo chmod 0600 ~www-data/.postgresql/root.crt
     sudo chown -R www-data:www-data ~www-data/.postgresql
     ```

   - Ubuntu 18

     ```bash
     echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
     wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
     sudo apt-get update
     sudo apt-get -q -y install php7.2-pgsql php7.2-curl php7.2-json php7.2-cgi php7.2 libapache2-mod-php7.2 apache2 php-mail php7.2-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
     sudo mkdir ~www-data/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~www-data/.postgresql/root.crt
     sudo chmod 0600 ~www-data/.postgresql/root.crt
     sudo chown -R www-data:www-data ~www-data/.postgresql
     ```

   - CentOS 6

     ```bash
     sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-6-x86_64/pgdg-centos10-10-2.noarch.rpm
     sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
     sudo yum check-update
     sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
     sudo mkdir ~apache/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
     sudo chmod 0600 ~apache/.postgresql/root.crt
     sudo chown -R apache:apache ~apache/.postgresql
     ```

   - CentOS 7

     ```bash
     sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
     sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
     sudo yum check-update
     sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
     sudo mkdir ~apache/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
     sudo chmod 0600 ~apache/.postgresql/root.crt
     sudo chown -R apache:apache ~apache/.postgresql
     ```

   {% endlist %}

## Configure the Apache2 web server {#configure-apache2}

1. Perform the basic configuration of Apache2:

   {% list tabs %}

   - Ubuntu 14

     ```bash
     sudo a2enmod php5
     sudo a2dismod mpm_event
     sudo a2enmod mpm_prefork
     sudo a2enmod rewrite
     sudo chown -R www-data /var/www/html/
     ```

   - Ubuntu 16

     ```bash
     sudo a2enmod php7.0
     sudo a2dismod mpm_event
     sudo a2enmod mpm_prefork
     sudo a2enmod rewrite
     sudo chown -R www-data /var/www/html/
     ```

   - Ubuntu 18

     ```bash
     sudo a2enmod php7.2
     sudo a2dismod mpm_event
     sudo a2enmod mpm_prefork
     sudo a2enmod rewrite
     sudo chown -R www-data /var/www/html/
     ```

   - CentOS

     ```bash
     sudo chown -R apache /var/www/html/
     ```

   {% endlist %}

1. Specify the virtual host settings in the Apache2 configuration file. You can edit the file in the `nano` editor:

   {% list tabs %}

   - Ubuntu

     ```bash
     sudo nano /etc/apache2/sites-enabled/000-default.conf
     ```

   - CentOS

     ```bash
     sudo nano /etc/httpd/conf.d/joomla.conf
     ```

   {% endlist %}

   Make the file look like:

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

1. Restart the web server:

   {% list tabs %}

   - Ubuntu

     ```bash
     sudo service apache2 restart
     ```

   - CentOS

     ```bash
     sudo service httpd restart
     ```

   {% endlist %}

1. This step should only be performed on a VM running CentOS.

   Change the SELinux settings:

   ```bash
   sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/html(/.*)?"
   sudo semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html(/.*)?"
   sudo restorecon -R /var/www/html
   setsebool -P httpd_can_network_connect 1
   ```

1. This step should only be performed on a VM running CentOS 6.

   Open network ports 80 and 443 using the `iptables` utility:

   ```bash
   sudo iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
   sudo iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
   sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```

## Configure Joomla {#configure-joomla}

Configure Joomla following the [instructions](https://docs.joomla.org/J3.x:Installing_Joomla/en) on the project website.

During the configuration process, you'll need the DB connection settings. To get the parameters and configure them correctly, do the following:

1. Get the addresses of the DB cluster hosts in the management console:
   1. Open the folder where the DB cluster was created.
   1. Select **{{ mpg-name }}**.
   1. Select the cluster `joomla-pg-tutorial-db-cluster`.
   1. Open the **Hosts** tab.
   1. In the **Address (domain name)** column, find the host addresses.

1. At the **Database** step, fill in the following fields  in the Joomla web installer:
   * **DB type**: `PostgreSQL`.
   * **DB server name**:

     ```
     <address of host 1>,<address of host 2>,<address of host 3> port=6432 sslmode=verify-full target_session_attrs=read-write
     ```

   * **Username**:`joomla`.
   * **Password**: enter the DB user's password.
   * **DB name**: `joomla-pg-tutorial-db`.

For security reasons, Joomla may ask you to delete a special test file. On the VM, go to the `/var/www/html/installation` directory and delete the specified file from it.

## Upload the website files {#upload-files}

{% include [upload-files](../_tutorials_includes/upload-web-site-files.md) %}

## Configure the DNS {#configure-dns}

The domain name that you want to use for your website must be associated with the created `joomla-pg-tutorial-web` VM.

{% include [configure-a-record-and-cname](configure-a-record-and-cname.md) %}

## Check that the website is running {#test-site}

To check that the site is up, enter its IP address or domain name in your browser:

* `http://<virtual machine public IP address>`.
* `http://www.example.com`.

## How to delete created resources {#clear-out}

To stop paying for your deployed server and DB, just [delete the created VM](../../compute/operations/vm-control/vm-delete.md) `joomla-pg-tutorial-web` and [cluster {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md) `joomla-pg-tutorial-db-cluster`.

If you reserved a static public IP address specifically for this VM:
1. Open the **Virtual Private Cloud** in your folder.
1. Go to the **IP addresses** tab.
1. Find the address you need, click ![ellipsis](../../_assets/options.svg), and select **Delete**.
