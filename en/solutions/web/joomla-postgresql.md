# Joomla-based website with PostgreSQL

To set up a static website on Joomla:

1. [Create a VM for Joomla](#create-vm)
1. [Create a PostgreSQL DB cluster](#create-cluster)
1. [Install Joomla and additional components](#install)
1. [Configure Apache2 web server](#configure-apache2)
1. [Configure Joomla](#configure-joomla)
1. [Upload the website files](#upload-files)
1. [Configure DNS](#configure-dns)

## Before you start {#before-begin}

Before creating a VM and a DB cluster:

1. Go to the Yandex.Cloud [management console](https://console.cloud.yandex.com) and select the folder where you want to perform the operations.
1. Make sure the selected folder has a network with subnets in the availability zones `ru-cental1-a`, `ru-central1-b`, and `ru-central1-c`. To do this, click the **Virtual Private Cloud** tile on the folder page. If the list contains a network, click on its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

## 1. Create a VM for Joomla {#create-vm}

To create a VM:

1. On the folder page of the [management console](https://console.cloud.yandex.com), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name: `joomla-pg-tutorial-web`.

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.

1. Select the **Ubuntu** or **CentOS** public image.

1. In the **Computing resources** section:
    - Choose the platform.
    - Specify the required amount of vCPUs and RAM.

   The minimum configuration is enough for functional testing:
   * **Guaranteed vCPU share**: 5%.
   * **vCPU**: 1.
   * **RAM**: 1 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM.
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

Creating the VM may take several minutes.

When a VM is created, it is assigned an IP address and hostname (FQDN). This data can be used for SSH access.

## 2. Create a PostgreSQL DB cluster {#create-cluster}

1. On the folder page, click **Create resource** and select **PostgreSQL cluster**.
1. In the **Name** field, enter the cluster name: `joomla-pg-tutorial-db-cluster`.
1. In the **DB class** section, select **s1.nano**.
1. In the **Storage size** section, enter 10 GB.
1. In the **Database** section:
  1. In the **DB name** field, enter `joomla-pg-tutorial-db`.
  1. In the **Username** field, enter `joomla`.
  1. In the **Password** field, enter the password you will use to access the DB.
1. In the **Network** list, select the network your VM is connected to.
1. In the **Hosts** section, add two more hosts in the other availability zones. When creating hosts, do not enable **Public access** to them.
1. Click **Create cluster**.

Creating the DB cluster may take several minutes.

## 3. Install Joomla and additional components {#install}

After the `joomla-pg-tutorial-web` VM's status changes to `RUNNING`, do the following:

1. Go to the VM page of the [management console](https://console.cloud.yandex.com). In the **Network** section, find the VM's public IP address.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` tool on Linux and macOS and [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows.

      The recommended authentication method when connecting over SSH is using a key pair.  Don't forget to set up the created key pair: the private key must match the public key sent to the VM.

1. Download and unpack the Joomla archive:

    ```bash
    $ sudo mkdir -p /var/www/html/
    $ curl https://downloads.joomla.org/cms/joomla3/3-8-7/Joomla_3-8-7-Stable-Full_Package.tar.gz?format=gz -o Joomla_3-8-7-Stable-Full_Package.tar.gz -L
    $ sudo mv Joomla_3-8-7-Stable-Full_Package.tar.gz /var/www/html/
    $ (cd /var/www/html/ && sudo tar -zxvf Joomla_3-8-7-Stable-Full_Package.tar.gz)
    $ sudo rm /var/www/html/Joomla_3-8-7-Stable-Full_Package.tar.gz
    $ sudo mv /var/www/html/htaccess.txt /var/www/html/.htaccess
    ```

1. Install additional components:

    {% list tabs %}

    - Ubuntu 14
  
      ```bash
      $ echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
      $ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
      $ sudo apt-get update
      $ sudo apt-get -q -y install php5-pgsql php5-curl php5-json php5-cgi php5 libapache2-mod-php5 php5-mcrypt apache2 php5-common cron debconf-utils sendmail unzip iptables postgresql-client-10
      $ sudo mkdir ~www-data/.postgresql
      $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~www-data/.postgresql/root.crt
      $ sudo chmod 0600 ~www-data/.postgresql/root.crt
      $ sudo chown -R www-data:www-data ~www-data/.postgresql
      ```
  
    - Ubuntu 16
  
      ```bash
      $ echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
      $ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
      $ sudo apt-get update
      $ sudo apt-get -q -y install php7.0-pgsql php7.0-curl php7.0-json php7.0-cgi php7.0 libapache2-mod-php7.0 php7.0-mcrypt apache2 php-mail php7.0-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
      $ sudo mkdir ~www-data/.postgresql
      $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~www-data/.postgresql/root.crt
      $ sudo chmod 0600 ~www-data/.postgresql/root.crt
      $ sudo chown -R www-data:www-data ~www-data/.postgresql
      ```
  
    - Ubuntu 18
  
      ```bash
      $ echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
      $ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
      $ sudo apt-get update
      $ sudo apt-get -q -y install php7.2-pgsql php7.2-curl php7.2-json php7.2-cgi php7.2 libapache2-mod-php7.2 apache2 php-mail php7.2-common cron debconf-utils sendmail unzip iptables composer postgresql-client-10
      $ sudo mkdir ~www-data/.postgresql
      $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~www-data/.postgresql/root.crt
      $ sudo chmod 0600 ~www-data/.postgresql/root.crt
      $ sudo chown -R www-data:www-data ~www-data/.postgresql
      ```
  
    - CentOS 6
  
      ```bash
      $ sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-6-x86_64/pgdg-centos10-10-2.noarch.rpm
      $ sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
      $ sudo yum check-update
      $ sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
      $ sudo mkdir ~apache/.postgresql
      $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
      $ sudo chmod 0600 ~apache/.postgresql/root.crt
      $ sudo chown -R apache:apache ~apache/.postgresql
      ```
  
    - CentOS 7
  
      ```bash
      $ sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
      $ sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
      $ sudo yum check-update
      $ sudo yum -y install --enablerepo remi-php72 httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget postgresql10
      $ sudo mkdir ~apache/.postgresql
      $ sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
      $ sudo chmod 0600 ~apache/.postgresql/root.crt
      $ sudo chown -R apache:apache ~apache/.postgresql
      ```
  
    {% endlist %}

## 4. Configure Apache2 web server {#configure-apache2}

1. Perform the basic configuration of Apache2:

   {% list tabs %}

   - Ubuntu 14
  
     ```bash
     $ sudo a2enmod php5
     $ sudo a2dismod mpm_event
     $ sudo a2enmod mpm_prefork
     $ sudo a2enmod rewrite
     $ sudo chown -R www-data /var/www/html/
     ```
  
   - Ubuntu 16
  
     ```bash
     $ sudo a2enmod php7.0
     $ sudo a2dismod mpm_event
     $ sudo a2enmod mpm_prefork
     $ sudo a2enmod rewrite
     $ sudo chown -R www-data /var/www/html/
     ```
  
   - Ubuntu 18
  
     ```bash
     $ sudo a2enmod php7.2
     $ sudo a2dismod mpm_event
     $ sudo a2enmod mpm_prefork
     $ sudo a2enmod rewrite
     $ sudo chown -R www-data /var/www/html/
     ```
  
   - CentOS
  
     ```bash
     $ sudo chown -R apache /var/www/html/
     ```
  
   {% endlist %}

1. Specify the virtual host settings in the Apache2 configuration file. You can edit the file using the `nano` editor:

   {% list tabs %}

   - Ubuntu
  
     ```bash
     $ sudo nano /etc/apache2/sites-enabled/000-default.conf
     ```
  
   - CentOS
  
     ```bash
     $ sudo nano /etc/httpd/conf.d/joomla.conf
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
     $ sudo service apache2 restart
     ```
  
   - CentOS
  
     ```bash
     $ sudo service httpd restart
     ```
  
   {% endlist %}

1. This step should only be performed on a VM running CentOS.

   Change SELinux settings:

   ```bash
   $ sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/html(/.*)?"
   $ sudo semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html(/.*)?"
   $ sudo restorecon -R /var/www/html
   $ setsebool -P httpd_can_network_connect 1
   ```

1. This step should only be performed on a VM running CentOS 6.

   Open network ports 80 and 443 using the `iptables` utility:

   ```bash
   $ sudo iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
   $ sudo iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
   $ sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```

To check privacy Joomla may require to delete a test file. Open the `/var/www/html/installation` directory on your VM and delete a file.

## 5. Configure Joomla {#configure-joomla}

Configure Joomla following the [instructions](https://docs.joomla.org/J3.x:Installing_Joomla/en) on the project website.
During the configuration process, you'll need the DB connection settings. To get the parameters and configure them correctly, do the following:

1. Get the addresses of the DB cluster hosts in the management console:
    1. Open the folder where the DB cluster was created.
    1. Click on **{{ mpg-name }}**.
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

## 6. Upload the website files {#upload-files}

{% include [upload-files](../_solutions_includes/upload-web-site-files.md) %}

## 7. Configure DNS {#configure-dns}

The domain name that you want to use for your website must be associated with the created `joomla-pg-tutorial-web` VM.

{% include [configure-a-record-and-cname](../_solutions_includes/configure-a-record-and-cname.md) %}

