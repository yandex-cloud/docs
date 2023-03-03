---
title: "Website powered by Joomla CMS on PostgreSQL: Installation and setup"
description: "Joomla is a website management system written in PHP and JavaScript. This tutorial will teach you to deploy websites powered by Joomla CMS on a PostgreSQL database."
keywords:
  - joomla
  - CMS Joomla
  - postresql
  - joomla installation
  - joomla setup
  - joomla website hosting
---

# Joomla website with PostgreSQL

This tutorial will teach you to deploy websites powered by Joomla CMS and using the {{ PG }} database management system in a {{ yandex-cloud }} infrastructure.

To set up a static website on Joomla:
1. [Create a VM for Joomla](#create-vm)
1. [Create a PostgreSQL database cluster](#create-cluster).
1. [Install Joomla and additional components](#install).
1. [Configure the Apache2 web server](#configure-apache2).
1. [Configure Joomla](#configure-joomla).
1. [Upload the website files](#upload-files).
1. [Configure the DNS](#configure-dns).
1. [Check that the website is running](#test-site).

If you no longer need the website, [delete all its resources](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Make sure that the selected folder contains a network with subnets in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-c` availability zones. To do this, select **{{ vpc-name }}** on the folder page. If the list contains a network, click on its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of hosting a Joomla-powered website includes:
* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for a {{ PG }} DB cluster (see [pricing {{ mpg-full-name }}](../../managed-postgresql/pricing.md)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

{% endif %}

## Create a VM for Joomla {#create-vm}

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
1. Use the **Name** field to enter a VM name, such as `joomla-pg-tutorial-web`.
1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.
1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select [CentOS Stream](/marketplace/products/yc/centos-stream-8) as your public image.
1. Under **Computing resources**:
   * Choose a [platform](../../compute/concepts/vm-platforms.md).
   * Specify the necessary number of vCPUs and amount of RAM.

   The minimum configuration is enough for functional testing:
   * **Platform**: Intel Ice Lake.
   * **Guaranteed vCPU share**: 20%.
   * **vCPU**: 2.
   * **RAM**: 1 GB.
1. In **Network settings**, select the subnet to connect the VM to once it is created.
1. Enter the VM access information:
   * Enter the username in the **Login** field.
   * In the **SSH key** field, paste the contents of the public key file.
      You will need to create a key pair for the {% if lang == "ru" and audience != "internal" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %} connection yourself. To create keys, use third-party tools, such as `ssh-keygen` (on Linux or macOS) or [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) (on Windows).
1. Click **Create VM**.

The VM may take several minutes to create.

Once created, the VM is assigned an IP address and a host name (FQDN). This data can be used for SSH access.

## Create a PostgreSQL database cluster {#create-cluster}

1. On the folder page, click **Create resource** and select **{{ PG }} cluster**.
1. In the **Name** field, enter the cluster name: `joomla-pg-tutorial-db-cluster`.
1. Under **Host class**, select the appropriate host class.
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

After the `joomla-pg-tutorial-web` VM's status changes to `RUNNING`:
1. Under **Network** on the VM page in the [management console]({{ link-console-main }}) find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH. You can use the `ssh` utility in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

   The recommended authentication method when connecting over SSH is using a key pair. Don't forget to configure using the generated key pair: the private key must match the public key sent to the VM.

1. Download and unpack the Joomla archive:

   {% list tabs %}

   - CentOS Stream

      ```bash
      sudo mkdir -p /var/www/html/
      curl https://downloads.joomla.org/cms/joomla3/3-8-7/Joomla_3-8-7-Stable-Full_Package.tar.gz?format=gz -o Joomla_3-8-7-Stable-Full_Package.tar.gz -L
      sudo mv Joomla_3-8-7-Stable-Full_Package.tar.gz /var/www/html/
      (cd /var/www/html/ && sudo tar -zxvf Joomla_3-8-7-Stable-Full_Package.tar.gz)
      sudo rm /var/www/html/Joomla_3-8-7-Stable-Full_Package.tar.gz
      sudo mv /var/www/html/htaccess.txt /var/www/html/.htaccess
      ```

   {% endlist %}

1. Install additional components:

   {% list tabs %}

   - CentOS Stream

      ```bash
      sudo dnf install epel-release
      sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
      sudo yum -y install --enablerepo remi-modular httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget php-json
      sudo dnf module enable postgresql:13
      sudo dnf install postgresql-server
      ```
   {% endlist %}

1. Get and configure the SSL certificate:

   {% list tabs %}

   - CentOS Stream

      ```bash
      sudo mkdir ~apache/.postgresql
      sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
      sudo chmod 0600 ~apache/.postgresql/root.crt
      sudo chown -R apache:apache ~apache/.postgresql
      ```

   {% endlist %}

## Configure the Apache2 web server {#configure-apache2}

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

## Configure Joomla {#configure-joomla}

Configure Joomla following the [instructions]{% if lang == "ru" %}(https://docs.joomla.org/J3.x:Installing_Joomla/ru){% endif %}{% if lang == "en" %}(https://docs.joomla.org/J3.x:Installing_Joomla){% endif %} on the project website. During the configuration process, you'll need the DB connection settings.

1. Get the addresses of the DB cluster hosts in the management console:
   1. Open the folder where the DB cluster was created and select **{{ mpg-name }}**.
   1. Select the cluster `joomla-pg-tutorial-db-cluster`.
   1. Open the **Hosts** tab.
   1. Copy the host addresses from the **Host name** column.
1. At the **Database** step, fill in the following fields in the Joomla web installer:
   * **Database type**: `{{ PG }}`.
   * **DB server name**:

      ```bash
      <address of host 1>,<address of host 2>,<address of host 3> port=6432 sslmode=verify-full target_session_attrs=read-write
      ```

   * **Username**: `joomla`.
   * **Password**: enter the DB user's password.
   * **DB name**: `joomla-pg-tutorial-db`.

1. For security reasons, Joomla may ask you to create or delete a special test file. On the VM, go to the `/var/www/html/installation` folder and create or delete the specified file there.
1. Create an empty file `configuration.php` to safe configuration and configure write permissions for the folder:

   ```
   sudo touch /var/www/html/configuration.php
   sudo chmod 655 /var/www/html/configuration.php
   sudo chown -R apache:apache /var/www/html/
   sudo restorecon -R /var/www/html
   ```

1. After the installation is completed, delete the `installation` directory. This is a Joomla security requirement:
   ```bash
   sudo rm -rf /var/www/html/installation
   ```

## Upload the website files {#upload-files}

1. Under **Network** on the VM page in the [management console]({{ link-console-main }}) find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH.
1. Grant your user write access to the directory `/var/www/html`:

   ```bash
   sudo chown -R "$USER":apache /var/www/html
   ```

1. Upload the website files to the VM via [SCP]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/SCP){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Secure_copy_protocol){% endif %}.

   {% list tabs %}

   - Linux/macOS

      Use the `scp` command-line utility:

      ```bash
      scp -r <path to the file directory> <VM username>@<VM IP address>:/var/www/html
      ```

   - Windows

      Use [WinSCP](https://winscp.net/eng/download.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}

## Configure the DNS {#configure-dns}

You need to bind the domain name you wish to use for your website to the created `joomla-pg-tutorial-web` VM. You can use the {{ dns-name }} service to manage your domain.

{% include [configure-a-record-and-cname](../../_tutorials/web/configure-a-record-and-cname.md) %}

## Check that the website is running {#test-site}

To check that the site is up, enter its IP address or domain name in your browser:
* `http://<virtual machine public IP address>`.
* `http://www.example.com`.

## How to delete created resources {#clear-out}

To stop paying for your deployed server, simply delete the [created VM](../../compute/operations/vm-control/vm-delete.md) `joomla-pg-tutorial-web` and the [{{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md) `joomla-pg-tutorial-db-cluster`.

If you reserved a static public IP address specifically for this VM:
1. Select **{{ vpc-name }}** in your folder.
1. Go to the **IP addresses** tab.
1. Find the required address, click ![ellipsis](../../_assets/options.svg), and select **Delete**.
