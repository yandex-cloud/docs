1. [Prepare your cloud](#before-you-begin).
1. [Create a VM with the OpenCart platform](#create-vm).
1. [(Optional) Create a {{ MY }} DB cluster](#create-mysql).
1. [Configure OpenCart](#configure-opencart).

If you no longer need the resources you created, [delete them](#clear-out).


## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [opencart-paid-resources](../_tutorials_includes/opencart-paid-resources.md) %}

## Create a VM with the OpenCart platform {#create-vm}

The OpenCart platform and the required components, including PHP and {{ MY }}, will be pre-installed on the VM boot disk.

To create a VM:

{% list tabs %}

- Management console

   1. On the [management console]({{ link-console-main }}) [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page, click **Create resource** and select **Virtual machine**.
   1. In the **Name** field, enter a name for the VM, e.g., `opencart`. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Select an [availability zone](../../overview/concepts/geo-scope.md) for your VM.
   1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab and select [OpenCart](/marketplace/products/yc/opencart-3) as your public [image](../../compute/concepts/image.md).
   1. Under **Disks**, select a 13 GB [SSD](../../compute/concepts/disk.md).
   1. Under **Computing resources**, specify the following configuration:
      * **Platform**: `Intel Ice Lake`
      * **Guaranteed vCPU share**: `20%`
      * **vCPU**: `2`
      * **RAM**: `4 GB`
   1. Under **Network settings**:
      * Select the [network](../../vpc/concepts/network.md#network) and [subnet](../../vpc/concepts/network.md#subnet) to connect your VM to. If you do not have a network or subnet yet, you can create them on the VM creation page: click **Create new network** or **Create new subnet**.
      * Under **Public address**, keep **Auto** to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.
   1. Under **Access**, specify the information required to access the VM:
      * In the **Login** field, enter the preferred username for the user to be created on the VM, e.g., `ubuntu`.
      * In the **SSH key** field, paste your public SSH key. You need to create a key pair for the SSH connection yourself. To learn how, see [Connecting to a VM via SSH](../../compute/operations/vm-connect/ssh.md).
   1. Click **Create VM**.
   1. [Get the public IP address of the VM](../../compute/operations/instance-groups/get-info.md): you will need it later to [configure OpenCart](#configure-opencart).

{% endlist %}

If you expect a significant load on the DB or would like to use a managed DBMS service, [create a DB cluster](#create-mysql) using {{ mmy-name }}. If not, [configure OpenCart](#configure-opencart).

## Create a {{ MY }} DB cluster {#create-mysql}

{{ mmy-name }} takes control of DBMS support and maintenance, which includes status and current activity monitoring, automatic backup, and easily configurable fault tolerance functionality.

If you do not need a cluster, skip this step and [configure OpenCart](#configure-opencart).

To create a DB cluster:

{% list tabs %}

- Management console

   1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **{{ MY }} cluster**.
   1. Specify a name for the cluster, e.g., `opencart`.
   1. Under **Host class**, select `s2.micro`. These characteristics are enough for the system to run under a normal workload.
   1. Under **Database**, enter:
      * **DB name**: Keep the default value, `db1`.
      * **Username** to connect to the DB: Keep the default value, `user1`.
      * **Password** for OpenCart to access the {{ MY }} DB.
   1. Under **Hosts**, change the **Availability zone** for the DB, if needed. To do this, click ![pencil](../../_assets/console-icons/pencil.svg) to the right of the currently selected availability zone, and select the availability zone from the drop-down list.

      {% note tip %}

      We recommend selecting the same availability zone as when you created the VM. This reduces latency between the VM and the DB.

      {% endnote %}

   1. (Optional) If you want to ensure fault tolerance for the DB, add more hosts to the cluster by clicking **Add host** and specifying the availability zone for the host.
   1. Leave the other fields unchanged.
   1. Click **Create cluster**.

{% endlist %}

Creating a DB cluster may take a few minutes. After creating, [configure OpenCart](#configure-opencart).

## Configure OpenCart {#configure-opencart}

{% include [opencart-configure](../_tutorials_includes/opencart-configure.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `opencart` VM.
1. If you used a {{ MY }} database, [delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md) (in the example, the database cluster is created under the `opencart` name).

If you reserved a static public IP address specifically for this VM:
1. Select **{{ vpc-short-name }}** in your folder.
1. Go to the **IP addresses** tab.
1. Find the required IP address, click ![ellipsis](../../_assets/console-icons/ellipsis.svg), and select **Delete**.
