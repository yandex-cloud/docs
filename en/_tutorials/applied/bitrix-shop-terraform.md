1. [Prepare your cloud](#before-you-begin).
1. [Create an infrastructure](#deploy).
1. [Configure your VM for 1C-Bitrix](#configure-server).
1. [Configure 1C-Bitrix](#configure-bitrix).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [bitrix-shop-paid-resources](../_tutorials_includes/bitrix-shop-paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [bitrix-create-terraform](../_tutorials_includes/bitrix-create-terraform.md) %}

## Configure your VM for 1C-Bitrix {#configure-server}

{% include [bitrix-website-configure-server](../_tutorials_includes/bitrix-website-configure-server.md) %}

## Configure 1C-Bitrix {#configure-bitrix}

{% include [bitrix-shop-configure-bitrix](../_tutorials_includes/bitrix-shop-configure-bitrix.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `bitrix-website.tf` configuration file and delete from it the description of the infrastructure you created.
1. Apply the changes:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}