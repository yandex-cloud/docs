# Creating a cluster of 1C:Enterprise Linux servers with {{ mpg-name }}

{{ yandex-cloud }} lets you create PostgreSQL clusters optimized for 1C:Enterprise. To configure the use of 1C:Enterprise, you need to create a working server, a license server, and a {{ mpg-name }} cluster. For 1C servers to run correctly, you should disable security services on them. Therefore the cluster will be accessed via an encrypted OpenVPN server connection, while the 1C servers will have no access to the internet. The 1C servers will be running CentOS Stream. The 1C cluster will be configured using the Windows administration console.

{% note info %}

To use 1C:Enterprise, you need a license. For more information about licenses and their installation, see the [1C:Enterprise website](https://its.1c.ru/).

{% endnote %}

To configure 1C:Enterprise servers:

1. [Before you start](#before-you-begin).
1. [Prepare the infrastructure](#prepare).
1. [Create a VM for the 1C:Enterprise server](#create-1c-vm).
1. [Create a VM for the license server](#create-1c-license-vm).
1. [Create a {{ mpg-name }} cluster](#create-pg-cluster).
1. [Set up a Samba server](#set-up-samba).
1. [Install the 1C:Enterprise server](#setup-1c-server).
1. [Set up a Samba server for the license server](#set-up-samba-for-license-server).
1. [Install the 1C:Enterprise server for the license server](#setup-1c-license-server).
1. [Set up a server cluster](#setup-cluster).
1. [Set up an infobase](#setup-infobase).
1. [Connect to the infobase](#connect-to-infobase).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost for 1C-Enterprise in {{ yandex-cloud }} includes:

* A fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for the continuously running {{ mpg-name }} cluster (see [pricing for {{ mpg-full-name }}](../../managed-postgresql/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Prepare the infrastructure {#prepare}

1. Make sure that you install the 1C:Enterprise client to check the performance of the infobase and the 1C administration console to manage the server cluster on your computer.
1. Make sure you have a VM running in your cloud with [OpenVPN configured](../routing/openvpn.md) for a secure connection to the 1C servers.

{% note info %}

You can download the necessary distributions from the [1C:Enterprise website](https://its.1c.ru/).

{% endnote %}

## Create a VM for the 1C:Enterprise server {#create-1c-vm}

To create a VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

2. In the **Name** field, enter the VM name: `server-1c`.

3. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

4. Under **Images from {{ marketplace-name }}**, click **Select**. Select a public [CentOS Stream](/marketplace/products/yc/centos-stream-8) image.

5. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md).
    - Specify the number of vCPUs and amount of RAM:
       * **vCPU**: 4.
       * **Guaranteed vCPU share**: 100%.
       * **RAM**: 4 GB.

6. In the **Network settings** section, select the network and subnet to connect the VM to. If you don't have a network or subnet, create them right on the VM creation page.

7. In the **Public address** field, leave the value **No address**. The VM will be accessed via the OpenVPN server.

8. Specify data required for accessing the VM:

    - Enter the username in the **Login** field.

    - In the **SSH key** field, paste the contents of the public key file.

      You need to create a key pair for the SSH connection yourself. [Learn how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

9. Click **Create VM**.

Creating the VM may take several minutes.

## Create a VM for the license server {#create-1c-license-vm}

Install the 1C:Enterprise license on a separate server. This way changes to the configuration of other servers won't affect the installed license.

To create a VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

2. In the **Name** field, enter the VM name: `licensing-server-1c`.

3. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

4. Under **Images from {{ marketplace-name }}**, click **Select**. Select a public **CentOS Stream** image.

5. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md).
    - Specify the number of vCPUs and amount of RAM:
       * **vCPU**: 4.
       * **Guaranteed vCPU share**: 100%.
       * **RAM**: 4 GB.

6. In the **Network settings** section, select the network and subnet to connect the VM to. The VM should be created in the same subnet as the OpenVPN server.

7. In the **Public address** field, leave the value **No address**. The VM will be accessed via the OpenVPN server.

8. Specify data required for accessing the VM:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.

9. Click **Create VM**.

Creating the VM may take several minutes.

## Create a cluster {{ mpg-name }} {#create-pg-cluster}

{{ yandex-cloud }} lets you create {{ mpg-name }} clusters optimized for 1C:Enterprise. Cluster settings may vary depending on your project requirements.

To create a {{ mpg-name }} cluster optimized for 1C:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **{{ mpg-name }} cluster**.

1. In the **Name** field, enter the cluster name: `1c-pg`.

1. In the **Version** list, select `10-1c`.

1. Under **Host class**, select **s2.small**.

1. Under **Storage size**, enter **local-ssd** and 100 GB.

1. Under **Database**, enter:
    - **DB name**: `1c-database`.
    - **Username**: `user1`.
    - **Password**: The password you'll use to access the database.
    - **Network**: The network where the cluster will reside.
    - **Sorting locale**: `ru_RU.UTF-8`.
    - **Character set locale**: `ru_RU.UTF-8`.

1. Under **Hosts**, select different availability zones for your hosts to ensure their fault tolerance.

1. Click **Create cluster**.

Creating the DB cluster may take several minutes.

## Set up a Samba server {#set-up-samba}

[Connect](../../compute/operations/vm-connect/ssh.md) to the `server-1c` VM via SSH.

1. Install Samba, the necessary dependencies, and the `nano` text editor:

   ```
   sudo yum install nano samba samba-client samba-common, net-utils
   ```

1. Disable IPv6 to avoid server conflicts. To do this, open the file `/etc/sysctl.conf `:

   ```
   sudo nano /etc/sysctl.conf
   ```

1. Add the following lines to the file:

   ```
   net.ip6.conf.all.disable_ipv6 = 1
   net.ip6.conf.default.disable_ipv6 = 1
   ```

1. Add the following lines to the file `/etc/sysconfig/network`:

   ```
   NETWORKING_IPv6=no
   HOSTNAME=server-1c
   ```

1. Configure a shared directory. Open the Samba configuration file:

   ```
   sudo nano /etc/samba/smb.conf
   ```

1. Make the file look like:

   ```
   [global]
           workgroup = WORKGROUP
           server string = Samba Server%v
           netbios name = centos
           security = user
           map to guest = bad user
           dns proxy = no
           passdb backend = tdbsam
           printing = cups
           printcap name = cups
           load printers = yes
           cups iptions = raw
           security = user
   
   [files]
           path = /1c-files
           browsable = yes
           writable = yes
           guest ok = yes
           read only = no
   ```

1. Create a shared directory and grant access rights to it:

   ```
   sudo mkdir /1c-files
   sudo chmod -R 777 /1c-files
   ```

1. Disable the firewall:

   ```
   sudo systemctl stop firewalld
   sudo systemctl disable firewalld
   ```

1. Disable SELinux. Run `sudo nano /etc/sysconfig/selinux` to open the SELinux configuration file and edit the `SELINUX` parameter:

   ```
   SELINUX=disabled
   ```

1. Add the Samba server service to the startup script and restart it:

   ```
   sudo systemctl enable smb.service
   Created symlink from /etc/systemd/system/multi-user.target.wants/smb.service to /usr/lib/systemd/system/smb.service.
   sudo systemctl restart smb.service
   ```

## Install the 1C:Enterprise server {#setup-1c-server}

Install the 1C:Enterprise server on the VM:

1. Upload the distribution archive to your VM's `1c-files` directory.
1. Unpack the distribution and run the installation:

   ```
   sudo tar –xvf  /1c-files/<archive name>
   sudo yum localinstall /1c-files/*.rpm 
   ```

1. Start the 1C server:

   ```
   sudo systemctl start srv1cv83
   ```

1. Make sure the 1C:Enterprise server service is running:

   ```
   systemctl status srv1cv83
   ● srv1cv83.service - SYSV: Starts and stops the 1C:Enterprise daemons
      Loaded: loaded (/etc/rc.d/init.d/srv1cv83; bad; vendor preset: disabled)
      Active: active (exited) since Tue 2020-02-04 14:40:43 UTC; 4 days ago
      Docs: man:systemd-sysv-generator(8)
   Process: 27364 ExecStart=/etc/rc.d/init.d/srv1cv83 start (code=exited, status=0/SUCCESS)
   ```

## Set up a Samba server for the license server {#set-up-samba-for-license-server}

[Connect](../../compute/operations/vm-connect/ssh.md) to the `server-1c` VM via SSH.

1. Install Samba, the necessary dependencies, and the `nano` text editor:

   ```
   sudo yum install nano samba samba-client samba-common, net-utils
   ```

1. Disable IPv6 to avoid server conflicts. To do this, open the file `/etc/sysctl.conf `:

   ```
   sudo nano /etc/sysctl.conf
   ```

1. Add the following lines to the file:

   ```
   net.ip6.conf.all.disable_ipv6 = 1
   net.ip6.conf.default.disable_ipv6 = 1
   ```

1. Run `sudo nano /etc/sysconfig/network` to add the following lines to the `/etc/sysconfig/network` file:

   ```
   NETWORKING_IPv6=no
   HOSTNAME=server-1c
   ```

1. Configure a shared directory. To do this, open the Samba configuration file:

   ```
   sudo nano /etc/samba/smb.conf
   ```

1. Make the file look like:

   ```
   [global]
           workgroup = WORKGROUP
           server string = Samba Server%v
           netbios name = centos
           security = user
           map to guest = bad user
           dns proxy = no
           passdb backend = tdbsam
           printing = cups
           printcap name = cups
           load printers = yes
           cups iptions = raw
           security = user
   
   [files]
           path = /1c-files
           browsable = yes
           writable = yes
           guest ok = yes
           read only = no
   ```

1. Create a shared directory and grant access rights to it:

   ```
   sudo mkdir /1c-files
   sudo chmod -R 777 /1c-files
   ```

1. Disable the firewall:

   ```
   sudo systemctl stop firewalld
   sudo systemctl disable firewalld
   ```

1. Disable SELinux. Run `sudo nano /etc/sysconfig/selinux` to open the SELinux configuration file and edit the `SELINUX` parameter:

   ```
   SELINUX=disabled
   ```

1. Add the Samba server service to the startup script and restart it:

   ```
   sudo systemctl enable smb.service
   Created symlink from /etc/systemd/system/multi-user.target.wants/smb.service to /usr/lib/systemd/system/smb.service.
   sudo systemctl restart smb.service
   ```

## Install the 1C:Enterprise server for the license server {#setup-1c-license-server}

Install the 1C:Enterprise server on the VM:

1. Upload the distribution archive to your VM's `1c-files` directory.
1. Unpack the distribution and run the installation:

   ```
   sudo tar –xvf  /1c-files/<archive name>
   sudo yum localinstall /1c-files/*.rpm 
   ```

1. Start the 1C server:

   ```
   sudo systemctl start srv1cv83
   ```

1. Make sure the 1C:Enterprise server service is running:

   ```
   systemctl status srv1cv83
   ● srv1cv83.service - SYSV: Starts and stops the 1C:Enterprise daemons
      Loaded: loaded (/etc/rc.d/init.d/srv1cv83; bad; vendor preset: disabled)
      Active: active (exited) since Tue 2020-02-04 14:40:43 UTC; 4 days ago
      Docs: man:systemd-sysv-generator(8)
   Process: 27364 ExecStart=/etc/rc.d/init.d/srv1cv83 start (code=exited, status=0/SUCCESS)
   ```

## Set up a server cluster {#setup-cluster}

Before getting started, configure the server roles and add the infobase to the cluster.

1. Run the 1C administration console on your computer.
1. Add the 1C:Enterprise central server Open the context menu of the server list, select **New** and **1C:Enterprise central server 8.3**.
1. In the **Name** field, enter `server-1c` and click **OK**. You'll see the local cluster in the tree on the left.
1. Add the working server to the cluster. Open the **Working servers** context menu, choose **New** and **Working server**. In the **Computer** field of the window that opens, enter `licensing-server-1c`. This server will be used to issue licenses to other servers.
1. In the **Requirements of functionality purpose** section of the `licensing-server-1c`, open the context menu and select **New** and **Requirement of functionality purpose**.
   - In the **Requirement object** list, select **Any requirement object**.
   - In the **Requirement type** list, select **Do not assign**.
   - Leave the other parameters as they are and click **OK**.
1. Apply requirements for assigning functionality to the cluster: open the cluster's context menu and select **Apply requirements of functionality purpose (full)**.
1. Add another requirement for assigning functionality to the `licensing-server-1c` with the following parameters:
   - In the **Requirement object** list, select **Licensing service**.
   - In the **Requirement type** list, select **Assign**.
   - Leave the other parameters as they are and click **OK**.
1. Apply requirements for assigning functionality to the cluster: open the cluster's context menu and select **Apply requirements of functionality purpose (full)**.
1. Add a requirement for assigning functionality to the `server-1c` with the following parameters:
   - In the **Requirement object** list, select **Client connection**.
   - In the **Requirement type** list, select **Assign**.
   - Leave the other parameters as they are and click **OK**.
1. Add another requirement for assigning functionality to the `server-1c` with the following parameters:
   - In the **Requirement object** list, select **Licensing service**.
   - In the **Requirement type** list, select **Do not assign**.
   - Leave the other parameters as they are and click **OK**.
1. Apply requirements for assigning functionality to the cluster: open the cluster's context menu and select **Apply requirements of functionality purpose (full)**.

## Set up the infobase {#setup-infobase}

1. In the administration console, open the **Infobases** context menu, select **New** and **Infobase**.

1. In the window that opens, set the parameters:
   - **Name**: The name of the database in the {{ mpg-name }} cluster, `1c-database`.
   - **Secure connection**: **continuously**.
   - **Database server**: Your DB host address and port, such as `rc1a-cwxzr4yimhzgn5pp.{{ dns-zone }} port=6432`.
   - **DBMS type**: **PostgreSQL**.
   - **Database**: The DB name, `1c-database`.
   - **Database server user**: `user1`.
   - **Database user password**: The user password that you set when creating the cluster.
   - **Allow license issuing by 1C:Enterprise server**: **Yes**.
   - **Language (Country)**: **English (United States)**.
   - **Create database if none present**: Disabled.
   - **Lock execution of scheduled jobs**: Disabled.

   Click **OK**.

## Connect to the infobase {#connect-to-infobase}

1. Connect to the OpenVPN server using the client.

1. Run the 1C:Enterprise client.

1. Click **Add**.

1. Select **Add an existing infobase to the list** and click **Next**.

1. Enter the infobase name, select **On 1C:Enterprise server**, and specify the following settings:
   - **Server cluster**: `server-1c.{{ region-id }}.internal`.
   - **Infobase name**: `1c`.

   Click **Next**.

1. Click **Ready**.

The infobase should appear on the list of infobases. You can now start configuring and using the database.

## Delete the created resources {#clear-out}

To stop paying for the deployed infrastructure, [delete](../../compute/operations/vm-control/vm-delete.md) the `server-1c` and `licensing-server-1c` VMs and the `1c-pg` cluster.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).

