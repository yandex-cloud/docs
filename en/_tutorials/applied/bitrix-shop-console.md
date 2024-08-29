1. [Prepare your cloud](#before-you-begin).
1. [Create and set up a cloud network](#create-network).
1. [Create a VM in the cloud](#create-vm).
1. [Create a {{ MY }} DB cluster](#create-mysql).
1. [Configure your VM for 1C-Bitrix](#configure-server).
1. [Configure 1C-Bitrix](#configure-bitrix).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [bitrix-shop-paid-resources](../_tutorials_includes/bitrix-shop-paid-resources.md) %}

## Create and set up a cloud network {#create-network}

{% include [bitrix-setup-network](../_tutorials_includes/bitrix-setup-network.md) %}

## Create a VM in the cloud {#create-vm}

{% include [bitrix-create-vm](../_tutorials_includes/bitrix-create-vm.md) %}

## Create a {{ MY }} DB cluster {#create-mysql}

{% include [bitrix-create-mysql-cluster](../_tutorials_includes/bitrix-create-mysql-cluster.md) %}

## Configure your VM for 1C-Bitrix {#configure-server}

{% include [bitrix-website-configure-server](../_tutorials_includes/bitrix-website-configure-server.md) %}

## Configure 1C-Bitrix {#configure-bitrix}

{% include [bitrix-shop-configure-bitrix](../_tutorials_includes/bitrix-shop-configure-bitrix.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `bitrixwebsite` VM.
1. [Delete](../../managed-mysql/operations/cluster-delete.md) the {{ MY }} database cluster named `Bitrix`.

If you reserved a static public IP address specifically for this VM:
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** in your folder.
1. Go to the **{{ ui-key.yacloud.vpc.switch_addresses }}** tab.
1. Find the required IP address, click ![ellipsis](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.common.delete }}**.