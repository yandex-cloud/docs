# Creating a cluster of 1C:Enterprise Windows servers with MS SQL Server

To configure the use of 1C:Enterprise in {{ yandex-cloud }}, you need to create a working server, a license server, and a database server. 1C servers will be running Windows Server Datacenter 2019 and the DB server will be running MS SQL Server 2016.

{% note info %}

To use 1C:Enterprise, you need a license. For more information about licenses and their installation, see the [1C:Enterprise website](https://its.1c.ru/).

{% endnote %}

To configure 1C:Enterprise servers:

1. [Before you start](#before-you-begin).
1. [Required paid resources](#paid-resources).
1. [Prepare the infrastructure](#prepare).
1. [Create a VM for the 1C:Enterprise server and license server](#create-1c-vm).
1. [Create a VM for the infobase](#create-infobase-vm).
1. [Set up a server cluster](#setup-cluster).
1. [Set up the license server](#setup-license-server).
1. [Set up the SQL Server](#setup-sql-server).
1. [Set up the infobase](#setup-info-base).
1. [Connect to the infobase](#connect-to-infobase).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

Before deploying the server, you need to sign up for {{ yandex-cloud }} and create a billing account:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The infrastructure support cost for 1C-Enterprise in {{ yandex-cloud }} includes:

* A fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for MS SQL Server licenses (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Prepare the infrastructure {#prepare}

1. Make sure that you install the 1C:Enterprise client to check the performance of the infobase and the 1C administration console to manage the server cluster on your computer.
1. Make sure you have a VM running in your cloud with [OpenVPN configured](../routing/openvpn.md) for a secure connection to the 1C servers.

{% note info %}

You can download the necessary distributions from the [1C:Enterprise website](https://its.1c.ru/).

{% endnote %}

## Create a VM for the 1C:Enterprise server and license server {#create-1c-vm}

Create two VMs: one for the 1C:Enterprise working server and one for the license server. Install the 1C:Enterprise license on a separate server. This way changes to the configuration of other servers won't affect the installed license.

Create two VMs for the 1C server and the license server:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

2. In the **Name** field enter the VM name `server-1c` for the 1C:Enterprise server and `license-server-1c` for the license server.

3. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

4. Under **Images from {{ marketplace-name }}**, click **Select**. Select the [Windows 2016 Datacenter](https://cloud.yandex.com/en-ru/marketplace/products/f2ep1515h63fnvqh6hkl) public image.

5. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md).
    - Specify the number of vCPUs and amount of RAM:
       * **vCPU**: 4.
       * **Guaranteed vCPU share**: 100%.
       * **RAM**: 8 GB.

6. Under **Network settings**, select the network and subnet to connect the VMs to. Both VMs must reside in the same subnet. If you don't have a network or subnet, create them right on the VM creation page.

7. In the **Public address** field, leave the value **No address**. The VM will be accessed via the OpenVPN server.

8. In the **Access** section **Password** field, specify the administrator's password to access the VM.

9. Click **Create VM**.

## Create a VM for the infobase {#create-infobase-vm}

The infobase will be running the MS SQL Server DBMS and be located on a separate VM.

To create an infobase VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

2. In the **Name** field, enter the VM name: `mssql-1c-server`.

3. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

4. Under **Images from {{ marketplace-name }}**, click **Select**. Select the [SQL Server 2016 Standard](https://cloud.yandex.com/en-ru/marketplace/products/f2epngblcno76k5st39r) public image.

5. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md).
    - Specify the number of vCPUs and amount of RAM:
       * **vCPU**: 4.
       * **Guaranteed vCPU share**: 100%.
       * **RAM**: 4 GB.

6. In the **Network settings** section, select the network and subnet to connect the VM to. The infobase VM must be in the same subnet as the 1C server.

7. In the **Public address** field, leave the value **No address**. The VM will be accessed via a bastion instance.

8. In the **Access** section **Password** field, specify the administrator's password to access the VM.

9. Click **Create VM**.

## Set up a server cluster {#setup-cluster}

1. Connect to the VM `server-1c` [using RDP](../../compute/operations/vm-connect/rdp.md). Log in as the `Administrator` and enter the password specified when creating the VM.
1. Install the 1C server from the distribution.
1. Start the 1C:Enterprise server administration console.
1. Add the 1C:Enterprise central server Open the context menu of the server list, select **New** and **1C:Enterprise central server 8.3**.
1. In the **Name** field, enter `server-1c` and click **OK**. You'll see the local cluster in the tree on the left.
1. Add a requirement for assigning functionality to the `server-1c` with the following parameters:
   - In the **Requirement object** list, select **Client connection**.
   - In the **Requirement type** list, select **Assign**.
   - Leave the other parameters as they are and click **OK**.
1. Add another requirement for assigning functionality to the `server-1c` with the following parameters:
   - In the **Requirement object** list, select **Licensing service**.
   - In the **Requirement type** list, select **Do not assign**.
   - Leave the other parameters as they are and click **OK**.
1. Apply requirements for assigning functionality to the cluster: open the cluster's context menu and select **Apply requirements of functionality purpose (full)**.

## Set up the license server {#setup-license-server}

1. Connect to the VM `license-server-1c` [using RDP](../../compute/operations/vm-connect/rdp.md). Log in as the `Administrator` and enter the password specified when creating the VM.
1. Install the 1C server from the distribution.
1. Connect to the VM `server-1c` [using RDP](../../compute/operations/vm-connect/rdp.md). Log in as the `Administrator` and enter the password specified when creating the VM.
1. Open the 1C:Enterprise server administration console.
1. Add the working server to the cluster. Open the **Working servers** context menu, choose **New** and **Working server**. In the Computer field of the window that opens, enter `licensing-server-1c`. This server will be used to issue licenses to other servers.
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

## Set up the SQL Server {#setup-sql-server}

1. Connect to the VM `sqlserver-1c` [using RDP](../../compute/operations/vm-connect/rdp.md). Log in as the `Administrator` and enter the password specified when creating the VM.

1. Open Microsoft SQL Server Management Studio and connect to the database server.

1. Change the authentication mode to the mixed one: open the `SQLSERVER-1C` server properties, go to the **Security** section, and select **SQL Server and Windows Authentication mode**. Click **OK**.

1. Restart the server.

1. Create a new database: open the **Databases** context menu and select **New Database**. Specify the following parameters:
   - **Database name**: `1c-database`.
   - Open the **Options** section. In the **Collation** field, select `Cyrillic_General_CI_AS`.

   Click **OK**.

1. In the tree on the left, select **Security**, open the **Logins** context menu, and choose **New Login...**. Specify the following settings:
   - **Login name**: `1c-user`.
   - **SQL Server authentication**: Enter your password and confirm it.
   - **Default database**: `1c`.

1. Open the **Server Roles** section. Grant the following roles to the user: `dbcreator`, `processadmin`, and `public`.

## Set up the infobase {#setup-info-base}

1. In the 1C server administration console, open the **Infobases** context menu, select **New** and **Infobase**.

1. In the window that opens, set the parameters:
   - **Name**: The name of the database on the SQL Server, `1c-database`.
   - **Secure connection**: **continuously**.
   - **Database server**: Your DB server address.
   - **DBMS type**: **MS SQL Server**.
   - **Database**: The DB name, `1c-database`.
   - **Database server user**: `1c-user`.
   - **Database user password**: The user password that you set when creating the DB server user.
   - **Allow license issuing by 1C:Enterprise server**: **Yes**.
   - **Language (Country)**: **English (United States)**.
   - **Create database if none present**: Disabled.
   - **Lock execution of scheduled jobs**: Disabled.

   Click **OK**.

## Connect to the infobase {#connect-to-infobase}

1. Connect to the OpenVPN server.

1. Run the 1C:Enterprise client.

1. Click **Add**.

1. Select **Add an existing infobase to the list** and click **Next**.

1. Enter the infobase name, select **On 1C:Enterprise server**, and specify the following settings:
   - **Server cluster**: `server-1c.ru-central1.internal`.
   - **Infobase name**: `1c`.

   Click **Next**.

1. Click **Ready**.

The infobase should appear on the list of infobases. You can now start configuring and using the database.

## Delete the created resources {#clear-out}

To stop paying for the deployed servers, [delete](../../compute/operations/vm-control/vm-delete.md) the `server-1c`, `license-server-1c`, and `sqlserver-1c` VMs.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).

