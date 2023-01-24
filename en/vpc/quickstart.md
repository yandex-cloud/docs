# Getting started with {{ vpc-short-name }}

Create a [cloud network and subnet](concepts/network.md) in an empty cloud and reserve a [static public IP address](concepts/address.md#public-addresses) for your VM using {{ vpc-name }}. Your cloud resources will be connected to the subnet and the static public IP address will remain reserved even if you stop or delete the VM it was attached to. This address can later be assigned to another VM.

{% note info %}

You can automatically create a cloud network and subnets in all availability zones when [creating a folder](../resource-manager/operations/folder/create.md) or [creating a VM](../compute/quickstart/quick-create-linux.md).

{% endnote %}

## Before you begin {#before-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
{% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
{% endif %}
1. If you don't have a folder, [create one](../resource-manager/operations/folder/create.md). When creating a folder, you can create a default virtual network with subnets in all availability zones.

## Create a cloud network {#create-network}

To create a cloud network:

1. In the [management console]({{ link-console-main }}) select a folder to create your cloud network in.
1. In the list of services, select **{{ vpc-name }}**.
1. Click **Create network**.
1. Enter a network name, like `test-network`.
1. Click **Create network**.

## Create a subnet {#create-subnet}

Create a subnet where cloud resources will be assigned [internal IP addresses](concepts/address.md#internal-addresses):

1. Click on the name of the cloud network created.
1. Click **Add subnet**.
1. Enter a subnet name, like `test-subnet-1`.
1. Select an availability zone from the drop-down list. Any zone from the list will be fine for the first subnet.
1. Enter the subnet CIDR: its IP address and mask (for example, `10.10.0.0/24`). For more information about subnet IP address ranges, see [Cloud networks and subnets](concepts/network.md).
1. Click **Create subnet**.

## Reserve a static public IP address {#reserve-address}

Reserve a static public IP address for your VM. You can assign this address to any VM and it won't change when the VM is stopped.

{% note warning %}

You're charged for the reserved static public IP address even if it's not assigned to any VM. For more information, see the [Pricing policy for {{ vpc-name }}](pricing.md).

{% endnote %}

To reserve an IP address:

1. In the list of services, select **{{ vpc-name }}**.
1. Go to **IP addresses**.
1. Click **Reserve address**.
1. Select the availability zone where you created the subnet in the previous step.
{% if product == "yandex-cloud" %}
1. Select the option **DDoS protection**, if you want to [protect your cloud resources from DDoS attacks](ddos-protection/index.md).
{% endif %}
1. In the window that opens, click **Reserve**.

## Delete a subnet and static public IP address {#delete-resources}

If you no longer need a subnet, [delete it](operations/subnet-delete.md).

If the reserved address isn't assigned to any resource, you can [delete](operations/address-delete.md) it.

## What's next {#what-is-next}

[Create a new VM](../compute/operations/vm-create/create-linux-vm.md), connect it to a subnet, and assign it a reserved public IP address.