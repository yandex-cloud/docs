1. [Prepare your cloud](#before-you-begin).
1. [Create a VM in the cloud](#create-vm).
1. [Create a {{ MY }} DB cluster](#create-mysql).
1. [Configure your VM for 1C-Bitrix](#configure-server).
1. [Configure 1C-Bitrix](#configure-bitrix).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [bitrix-shop-paid-resources](../_tutorials_includes/bitrix-shop-paid-resources.md) %}

## Create a VM in the cloud {#create-vm}

{% list tabs %}

- Management console

   1. On the [management console]({{ link-console-main }}) folder page, click **Create resource** and select **Virtual machine**.
   1. In the **Name** field, enter a name for the VM, such as `bitrix`.

      {% include [name-format](../../_includes/name-format.md) %}

   1. Select an [availability zone](../../overview/concepts/geo-scope.md) to put your virtual machine in. If you do not know which availability zone you need, leave the default one.
   1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select the [Ubuntu 18.04 lts](/marketplace/products/yc/ubuntu-18-04-lts) image.
   1. Under **Disks**, select a 13 GB SSD.
   1. Under **Computing resources**, specify the configuration for correct operation of 1C-Bitrix:
      * **Platform**: `Intel Ice Lake`
      * **Guaranteed vCPU share**: `20%`
      * **vCPU**: `2`
      * **RAM**: `4 GB`

   1. Under **Network settings**:
      * Select the **Network** and **Subnet** to connect the VM to. If you do not have a network or subnet, create them right in this section.
      * In the **Public address** field, leave the `Auto` value to assign the virtual machine a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

   1. Under **Access**, specify the information required to access the VM:
      * In the **Login** field, enter a username to create on the VM, such as `ubuntu`.
      * In the **SSH key** field, copy the value of your public SSH key. You will need to create a key pair for the SSH connection [yourself](../../compute/operations/vm-connect/ssh.md).

   1. Click **Create VM**.

{% endlist %}

## Create a {{ MY }} DB cluster {#create-mysql}

{% list tabs %}

- Management console

   1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select the **MySQL cluster** option.
   1. In the **Name** field, enter a name for the VM, such as `bitrix-mysql`.

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Host class**, select the **Type** of the host: `s2.micro`.
   1. Under **Database**, enter:
      * **DB name**. Keep the default value: `db1`.
      * **Username** to connect to the database. Keep the default value: `user1`.
      * **Password** for 1C-Bitrix to access the database.

   1. Under **Hosts**, change the host's **Availability zone**. To do this, click ![pencil](../../_assets/console-icons/pencil.svg) in the host row and select the appropriate zone in the window that opens.

      We recommend selecting the same **availability zone** as when you created the VM. This reduces latency between the VM and database.

      For a fault-tolerant DB, you can add more hosts to the cluster. To do this, click **Add host**, select the availability zone and subnet, and click **Save**.
   1. Make sure that public access has not been requested for the cluster hosts; otherwise, 1C-Bitrix will not be able to connect to the cluster.
   1. Leave the other fields unchanged.
   1. Click **Create cluster**.

   Creating a DB cluster may take a few minutes.

{% endlist %}

## Configure your VM for 1C-Bitrix {#configure-server}

{% include [bitrix-shop-configure-server](../_tutorials_includes/bitrix-shop-configure-server.md) %}

## Configure 1C-Bitrix {#configure-bitrix}

{% include [bitrix-shop-configure-bitrix](../_tutorials_includes/bitrix-shop-configure-bitrix.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `bitrix` VM.
1. [Delete](../../managed-mysql/operations/cluster-delete.md) the {{ MY }} cluster named `bitrix-mysql`.

If you reserved a static public IP address specifically for this VM:
1. Select **{{ vpc-name }}** in your folder.
1. Go to the **IP addresses** tab.
1. Find the required address, click ![ellipsis](../../_assets/console-icons/ellipsis.svg), and select **Delete**.