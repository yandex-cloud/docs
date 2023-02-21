# 1C-Bitrix Online Store: Site Management

[1C-Bitrix: Site Management](https://ru.wikipedia.org/wiki/1%D0%A1-%D0%91%D0%B8%D1%82%D1%80%D0%B8%D0%BA%D1%81:_%D0%A3%D0%BF%D1%80%D0%B0%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5_%D1%81%D0%B0%D0%B9%D1%82%D0%BE%D0%BC) is a content management system (CMS) that can help you create an online store, corporate website, or news portal. It can also make it easy to manage your website's structure and content.

In this tutorial, you'll deploy and configure an online store built on the 1C-Bitrix platform. During the configuration process, you'll create a virtual machine in {{ yandex-cloud }}, deploy 1C-Bitrix on it, and launch the necessary services. You'll use a failover {{ mmy-name }} cluster as a database.

To deploy and configure 1C-Bitrix:
1. [Before you start](#before-you-begin)
1. [Create a VM in the cloud](#create-vm)
1. [Create a MySQL DB cluster](#create-mysql)
1. [Configure a server to work with 1C-Bitrix](#configure-server)
1. [Configure 1C-Bitrix](#configure-bitrix)


## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The infrastructure support cost for 1C-Bitrix includes:

* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for using a managed MySQL database (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).

{% endif %}

## Create a VM in the cloud {#create-vm}

To create a VM:

1. Go to the desired folder in the [management console]({{ link-console-main }}) by clicking the folder name under **Your resources**.
1. Click **Create resource** and select **Virtual machine**.
1. In the **Name** field, enter a name for the VM, such as `bitrix`.

   {% include [name-format](../../_includes/name-format.md) %}

1. Select an [availability zone](../../overview/concepts/geo-scope.md) to put your virtual machine in. If you don't know which availability zone you need, leave the default.
1. Under **Images from {{ marketplace-name }}**, select an image of the [Ubuntu 18.04 lts](/marketplace/products/f2e9qa7i4fmugh14tjnc) operating system.
1. Under **Disks**, select an SSD with 13 GB.
1. Under **Computing resources**, specify the configuration for proper operation of 1C-Bitrix:
   * **Platform**: Intel Ice Lake.
   * **Guaranteed vCPU share**: 20%.
   * **vCPU**: 2.
   * **RAM**: 4 GB.

1. Under **Network settings**:
   - Select the **Network** and **Subnet** to connect the VM to. If you don't have a network or subnet, create them right in this section.
   - In the **Public address** field, leave the **Auto** value to assign the virtual machine a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

1. Under **Access**, specify the information required to access the VM:
   - In the **Login** field, enter a username to create on the VM, such as `ubuntu`.
   - In the **SSH key** field, copy the value of your public SSH key. You need to [create](../../compute/operations/vm-connect/ssh.md) the SSH key pair yourself.

1. Click **Create VM**.


## Create a MySQL database cluster {#create-mysql}

To create a MySQL database cluster:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select the **MySQL cluster** option.
1. In the **Name** field, enter a name for the VM, such as `bitrix-mysql`.

   {% include [name-format](../../_includes/name-format.md) %}

1. Under **Host class**, select the **Type** of the host: **s2.micro**.
1. Under **Database**, enter:
   - **DB name**. Leave the default value, `db1`.
   - **Username** to connect to the database. Leave the default value, `user1`.
   - **Password** for 1C-Bitrix to access the database.

1. Under **Hosts**, change the host's **Availability zone**. To do this, click ![pencil](../../_assets/pencil.svg) in the host's row and select the desired zone in the resulting window.

   We recommend selecting the same **Availability zone** as when you created the VM. This reduces latency between the VM and database.

   To make the database fault-tolerant, you can add more hosts to the cluster. To do this, click **Add host**, select the availability zone and subnet, and click **Save**.
1. Make sure that no public access is requested for the cluster hosts, otherwise 1C-Bitrix won't be able to connect to the cluster.
1. Leave the other fields as they are.
1. Click **Create cluster**.

Creating the DB cluster may take several minutes.

## Configure the VM to work with 1C-Bitrix {#configure-server}

To configure the VM to work with 1C-Bitrix:

1. Log in to the virtual machine over SSH (`ubuntu` is the username you set when [creating the VM](#create-vm)):

   ```bash
   ssh ubuntu@<VM-public-IP>
   ```

   To find out the public IP address of your VM:
   1. Select the folder the VM is in using the [management console]({{ link-console-main }}).
   1. Select **{{compute-short-name}}**.
   1. Click on the name of your VM (`bitrix` in the example).
   1. In the window with general VM info that opens, you can find the public IP address in the **Public IPv4** field under **Network**.

1. Switch to admin mode:

   ```bash
   ubuntu@bitrix:~$ sudo -i
   root@bitrix:~#
   ```

1. Install the necessary software:

   ```bash
   root@bitrix:~# apt-get update
   root@bitrix:~# apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Go to the project's working directory:

   ```bash
   root@bitrix:~# cd /var/www/html/
   ```

1. Download the <q>1C-Bitrix: Site Management</q> distribution:

   ```bash
   root@bitrix:/var/www/html# wget https://www.1c-bitrix.ru/download/business_encode.tar.gz
   ```

1. Unpack the downloaded archive and delete unnecessary files:

   ```bash
   root@bitrix:/var/www/html# tar -zxf business_encode.tar.gz
   root@bitrix:/var/www/html# rm -f index.html business_encode.tar.gz
   ```

1. Assign the `www-data` user as the owner of the working directory of the project:

   ```bash
   root@bitrix:/var/www/html# chown -R www-data:www-data /var/www/html

   # Make sure the command worked
   root@bitrix:/var/www/html# ls -l
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

   The path to the configuration file may differ depending on the <q>1C-Bitrix</q> version. Specify the path to the current PHP version on the virtual machine.

   {% endnote %}


   | Previously | Now |
   |:---------------------------| :----------------------------|
   | short_open_tag = Off | short_open_tag = On |
   | display_errors = Off | display_errors = On |
   | memory_limit = 128M | memory_limit = 256M |
   | ;date.timezone = | date.timezone = Europe/Moscow |
   | ;opcache.revalidate_freq=2 | opcache.revalidate_freq = 0 |
   | ;mbstring.func_overload = 0 | mbstring.func_overload = 2 |

1. Configure the Apache server using the `/etc/apache2/sites-enabled/000-default.conf` file. To do this, add the following block after the `DocumentRoot /var/www/html` line:

   ```
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

The server is configured for 1C-Bitrix to run properly. Now you need to configure the 1C-Bitrix system itself.


## Configure 1C-Bitrix {#configure-bitrix}

Perform initial installation and setup of 1C-Bitrix:

1. Open the <q>1C-Bitrix: Site Management</q> web interface. To do this, open `http://<VM-public-IP-address>/`. A page opens asking you to install 1C-Bitrix.

1. Click **Next** on the installer welcome screen.

1. Read the license agreement and select **I accept the license agreement**. Then click **Next**.

1. You don't need to register the product (you can disable this option). Make sure the **Install in UTF-8 encoding** option is selected and click **Next**.

1. 1C-Bitrix checks if the server is configured correctly. Click **Next** at the bottom of the page.

1. Setting up the database.

   1. In the **Server** field, enter the fully qualified domain name of the created database. To find it:
      1. Open the folder page in the [management console]({{ link-console-main }}) in a new browser tab.
      1. Select **{{mmy-name}}**.
      1. In the table, click on the row of the DB cluster you created.
      1. Go to the **Hosts** tab.
      1. Hover over the **Hostname** field value and click ![copy](../../_assets/copy.svg).
   1. In the **Username** and **Password** fields, specify the data that you entered when creating the database.
   1. In the **Database name** field, specify the name of the database (`db1` in the example).
   1. Leave the default values in the other fields.
   1. Click **Next**.

1. Wait for the system installation and database initialization to complete.

1. Create an administrator (a user who will manage the system). Fill in the fields based on your personal data and click **Next**.

1. Select the **Online store** template and click **Next**.

1. Confirm the selection of the only template and click **Next**.

1. Select a color for the previously selected template and click **Next**.

1. Fill in the fields according to your requirements for the online store and click **Next**.

1. If necessary, enable the inventory management function and specify when to reserve items at the warehouse. Click **Next**.

1. Enter your company information and click **Next**.

1. Select the types of payers your online store should work with and click **Next**.

1. Select the payment and delivery methods your online store supports and click **Next**.

1. Wait for the system installation to complete.

1. When the installation is complete, click **Go to site**.

1. The online store interface opens in edit mode.

1. Click **Exit** in the upper-right corner of the page and you'll see the site homepage as a regular user. To return to edit mode, log in to the site using the 1C-Bitrix administrator credentials.

{% note tip %}

To make system backups, periodically [create disk snapshots](../../compute/operations/disk-control/create-snapshot.md) on your virtual machine.

{% endnote %}


## How to delete created resources {#clear-out}

To stop paying for the deployed server, [delete the virtual machine](../../compute/operations/vm-control/vm-delete.md) named `bitrix` and [delete the cluster](../../managed-mysql/operations/cluster-delete.md) named `bitrix-mysql`.

If you reserved a static public IP address specifically for this VM:

1. Select the **{{ vpc-short-name }}** in your folder.
1. Go to the **IP addresses** tab.
1. Find the required address, click ![ellipsis](../../_assets/options.svg), and select **Delete**.
