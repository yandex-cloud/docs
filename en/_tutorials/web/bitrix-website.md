
# 1C-Bitrix website

[1C-Bitrix: Site Management](https://www.1c-bitrix.ru/products/cms/) is a web project management system from 1C-Bitrix. It lets you easily manage the structure and content of your website without knowing programming or design. 1C-Bitrix: Site Management does the technical work for you.

In this tutorial, you'll deploy and configure a website using the 1C-Bitrix information portal template. During the configuration, you'll create a VM in {{ yandex-cloud }}, deploy the 1C-Bitrix image on it, and launch the necessary services. As a database, you'll deploy a managed MySQL database cluster and ensure its fault tolerance.

Resources used for proper operation of 1C-Bitrix:
* A VM running Ubuntu 18.04 LTS with access to an external network and hosting 1C-Bitrix.
* A MySQL cluster that serves as a database for the 1C-Bitrix website.

To deploy and configure 1C-Bitrix:
1. [Before you start](#before-you-begin).
1. [Create a VM in the cloud](#create-vm).
1. [Create a MySQL DB cluster](#create-mysql).
1. [Configure a server to work with 1C-Bitrix](#configure-server).
1. [Configure 1C-Bitrix](#configure-bitrix).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources

The cost for maintaining the 1C-Bitrix server includes:
* A fee for {{ compute-full-name }} disks and a continuously running VM (see [pricing for {{ compute-full-name }}](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for using a managed database (see [pricing for {{ mmy-name }}](../../managed-mysql/pricing.md)).

The current scenario uses the trial version of 1C-Bitrix with a trial period of 30 days. You can check the cost the product software versions on the [1C-Bitrix official website](https://www.1c-bitrix.ru).

{% endif %}

## Create a VM in the cloud {#create-vm}

To create a VM:
1. On the **Folder dashboard** folder page, in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
1. In the **Name** field, enter a name for the VM, such as `bitrixwebsite`.
1. Leave the default availability zone.
1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the [Ubuntu 20.04 lts](/marketplace/products/yc/ubuntu-20-04-lts) image.
1. Under **Disks**, select an SSD with 20 GB.
1. Under **Computing resources**:
   * Choose a [platform](../../compute/concepts/vm-platforms.md) for the VM.
   * For 1C-Bitrix to run properly, specify the following configuration:
     * **Platform**: Intel Ice Lake.
     * **Guaranteed vCPU share**: 20%.
     * **vCPU**: 2.
     * **RAM**: 4 GB.
1. Under **Network settings**:
   * Select the **Network** and **Subnet** to connect the VM to. If you don't have a network or subnet, create them right on the VM creation page.
   * In the **Public address** field, leave the **Auto** value to assign a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.
1. Under **Access**, specify the information required to access the VM:
   * In the **Login** field, enter your preferred username to be created on the VM, for example, `ubuntu`.
   * In the **SSH key** field, paste your public SSH key. You need to create a key pair for an SSH connection [yourself](../../compute/operations/vm-connect/ssh.md).
1. Click **Create VM**.

You may need to save [disk snapshots](../../compute/operations/disk-control/create-snapshot.md) of your VM. They contain a copy of the VM file system from when the snapshot was created.

You can use disk snapshots for various purposes, such as:
* Transferring data from one disk to another, for example, to a disk in a different availability zone.
* Creating a disk backup before performing operations that may cause damage to your data.
* Performing disk versioning by regularly creating snapshots of the disk.

## Create a MySQL database cluster {#create-mysql}

To create a MySQL database cluster:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **MySQL cluster**.

1. Under **Host class**, select `s2.micro`. These characteristics are enough for 1C-Bitrix to run.

1. Under **Storage size**, select the type of storage: either a more flexible network type (`network-hdd` or `network-ssd`) or faster local SSD storage (`local-ssd`). At this stage, leave the 10 GB `network-ssd` type. This size is enough for the current example.

1. Under **Database**, enter:
   * **DB name**. Leave the default value, `db1`.
   * **Username** to connect to the database. Leave the default value, `user1`.
   * **Password** for 1C-Bitrix to access the MySQL database.

1. Under **Hosts**, change the **Availability zone** for the database. To do this, click ![pencil](../../_assets/pencil.svg) in the line with host details. In the window that opens, select the desired availability zone and click **Save**.

   We recommend selecting the same availability zone as when you created the VM. This reduces latency between the VM and database.

1. To make your database fault-tolerant, you can add more hosts for it. To do this, select **Add host** and specify the availability zone to place it in.

1. Leave the other fields as they are.

1. Click **Create cluster**.

Creating the DB cluster may take several minutes. To check that the new cluster is available, select **Managed Service for MySQL** in the {{ yandex-cloud }} management console. On the **Clusters** tab, the cluster status should be **Running** and its state should be **Alive**.

## Configure a server to work with 1C-Bitrix {#configure-server}

To configure the server to work with 1C-Bitrix:

1. Log in to the created server using [SSH](../../compute/operations/vm-connect/ssh.md).

   ```bash
   ssh ubuntu@<VM-public-IP>
   ```

   `ubuntu`: The username in the **Login** field that you set when [creating the VM](#create-vm).

   To find out the public IP address of your VM, on the folder page in the [management console]({{ link-console-main }}):
   1. Choose the **Compute Cloud** section.
   1. Click on the name of your VM (in this example, it's **bitrixwebsite**).
   1. A window opens with general information about your VM. You can find the public IP address in the **Public IPv4** field under **Network**.

1. Get administrator rights.

   ```bash
   ubuntu@bitrixwebsite:~$ sudo -i
   root@bitrixwebsite:~#
   ```

1. Install the necessary software.

   ```bash
   root@bitrixwebsite:~# apt-get update
   root@bitrixwebsite:~# apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Go to the project's working directory.

   ```bash
   root@bitrixwebsite:~# cd /var/www/html/
   ```

1. Download the 1C-Bitrix: Site Management distribution.

   ```bash
   root@bitrixwebsite:/var/www/html# wget https://www.1c-bitrix.ru/download/standard_encode.tar.gz
   ```

1. Unpack the downloaded archive and delete unnecessary files.

   ```bash
   root@bitrixwebsite:/var/www/html# tar -zxf standard_encode.tar.gz
   root@bitrixwebsite:/var/www/html# rm -f index.html standard_encode.tar.gz
   ```

1. Assign the `www-data` user as the owner of the project's working directory.

   ```bash
   root@bitrixwebsite:/var/www/html# chown -R www-data:www-data /var/www/html
   root@bitrixwebsite:/var/www/html# ls -l
   total 76
   ...
   -rwxrwxr-x 1 www-data www-data   112 Mar 27  2013 readme.php
   drwxrwxr-x 2 www-data www-data  4096 May 15 13:50 upload
   -rwxrwxr-x 1 www-data www-data   691 Oct 27  2009 web.config
   ```

1. Configure the PHP settings.

   In accordance with the information system requirements, you need to edit the following variables in the configuration file `/etc/php/7.2/apache2/php.ini`.

   Previously | Now
   :--- | :---
   short_open_tag = Off | short_open_tag = On
   display_errors = Off | display_errors = On
   memory_limit = 128M | memory_limit = 256M
   ;date.timezone = | date.timezone = Europe/Moscow
   ;opcache.revalidate_freq = 2 | opcache.revalidate_freq = 0
   ;mbstring.func_overload = 0 | mbstring.func_overload = 2

   To edit the file, use the built-in `nano` editor:

   ```bash
   root@bitrixwebsite:/var/www/html# nano /etc/php/7.2/apache2/php.ini
   ```

   To find the parameter you need in the `nano` editor, press **Ctrl** + **W**. Look for the required parameter in the table above and save the changes using **Ctrl** + **O**. To exit the editor, press **Ctrl** + **X**.

1. Configure the Apache server. In accordance with the information system requirements, you need to edit the `/etc/apache2/sites-enabled/000-default.conf` file.

   1. Open the file in the text editor:

      ```bash
      root@bitrixwebsite:/var/www/html# nano /etc/apache2/sites-enabled/000-default.conf
      ```

   1. Add the following block after the `DocumentRoot /var/www/html` line:

      ```
      <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
      ```

   1. Restart the web server to apply all the new settings.

      ```bash
      root@bitrixwebsite:/var/www/html# service apache2 restart
      ```

After you run these commands, the server side is configured for proper operation of 1C-Bitrix.

## Configure 1C-Bitrix {#configure-bitrix}

Install and configure 1C-Bitrix:

1. Open the 1C-Bitrix: Site Management web interface at: `http://<VM-public-IP-address>/`. A page should open asking you to install 1C-Bitrix.

1. Click **Next**.

1. Read the license agreement and select **I accept the license agreement**. Then click **Next**.

1. Since registration is optional, uncheck the corresponding checkbox. Leave **Install in UTF-8 encoding** and click **Next**.

1. 1C-Bitrix checks if the server is configured correctly. View all the parameters on this page and click **Next**.

1. Specify the parameters of the created database:
   1. In the **Server** field, enter the fully qualified domain name of the created database. To find it:
      1. Open the [management console]({{ link-console-main }}) folder page in a new browser tab.
      1. Choose **Managed Service for MySQL**.
      1. In the table, select the database you created.
      1. Select the **Hosts** tab in the left menu.
      1. Hover over the **Hostname** (like `rc1c-cfazv1dbzv02u4qk`) and copy the database fully qualified domain name by clicking the ![copy](../../_assets/copy.svg) icon that appears. As a result, the fully qualified domain name is added to the hostname and the **Server** field should contain a name like `rc1c-cfazv1dbzv02u4qk.{{ dns-zone }}`.

   1. In the **Username** and **Password** fields, enter the data that you specified when creating the database in [Create a MySQL database cluster](#create-mysql).

   1. In the **Database name** field, specify the name of the created database (`db1`).

   1. Leave the default values in the other fields.

   1. Click **Next**.

1. Wait for the {{ MY }} database to initialize.

1. Create an administrator account to make changes to your system under. Fill in all the fields and click **Next**.

1. Select the **Information portal** template and click **Next**.

1. Confirm the selection of the only layout template and click **Next**.

1. Select a color and click **Next**.

1. Fill in all the fields according to your website requirements and click **Install**. This starts installing and configuring all system components. Wait for it to complete.

1. After a while, a page appears saying that the system is installed and configured. To start working with the website, click **Go to site**.

1. You're in content editing mode in the web interface of the system that is completely ready-to-use.

1. To see the website homepage from a user's point of view, click **Exit** in the upper-right corner of the page to exit from your website admin panel and go to `http://<VM-public-IP-address>/`. To return to edit mode, log in to the website using the 1C-Bitrix administrator credentials.

## How to delete created resources {#clear-out}

To stop paying for your deployed server, just [delete the created](../../compute/operations/vm-control/vm-delete.md) `bitrixwebsite` VM and [DB cluster named](../../managed-mysql/operations/cluster-delete.md) `BitrixMySQLdb`.

If you reserved a static public IP address specifically for this VM:
1. Select the **{{ vpc-short-name }}** in your folder.
1. Go to the **IP addresses** tab.
1. Find the address you need, click ![ellipsis](../../_assets/options.svg), and select **Delete**.