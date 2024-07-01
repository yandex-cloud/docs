# Getting started with {{ vpc-short-name }}

Create a [cloud network and subnet](concepts/network.md) in an empty cloud and reserve a [static public IP address](concepts/address.md#public-addresses) for your VM using {{ vpc-name }}. Your cloud resources will be connected to the subnet and the static public IP address will remain reserved even if you stop or delete the VM it was attached to. This address can later be assigned to another VM.

{% note info %}

You can automatically create a cloud network and subnets in all [availability zones](../overview/concepts/geo-scope.md) when [creating a folder](../resource-manager/operations/folder/create.md) or [creating a VM](../compute/quickstart/quick-create-linux.md).

{% endnote %}

## Getting started {#before-begin}

1. Log in or sign up to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. Go to [{{ billing-name }}]({{ link-console-billing }}) and make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md). While creating a folder, you can also create a default virtual network with subnets in all availability zones.

## Create a cloud network {#create-network}

To create a cloud network:

1. In the [management console]({{ link-console-main }}) select a folder to create your cloud network in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
1. Enter a name for the network, e.g., `test-network`.
1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

## Create a subnet {#create-subnet}

Create a subnet where cloud resources will be assigned [internal IP addresses](concepts/address.md#internal-addresses):

1. Click the name of the cloud network you created.
1. Click ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
1. Enter a name for the subnet, e.g., `test-subnet-1`.
1. Select an availability zone from the drop-down list. Any zone from the list will be fine for the first subnet.
1. Enter the subnet CIDR: its IP address and mask (for example, `10.10.0.0/24`). For more information about subnet IP address ranges, see [Cloud networks and subnets](concepts/network.md).
1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

## Reserve a static public IP address {#reserve-address}

Reserve a static public IP address for your VM. You can assign this address to any VM and it won't change when the VM is stopped.

{% note warning %}

You're charged for the reserved static public IP address even if it's not assigned to any VM. For more information, see the [{{ vpc-name }} pricing policy](pricing.md).

{% endnote %}

To reserve an IP address:

1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. Go to **{{ ui-key.yacloud.vpc.switch_addresses }}**.
1. Click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
1. In the window that opens, select the availability zone where you created the subnet in the previous step.
1. Select the **{{ ui-key.yacloud.common.field_ddos-protection-provider }}** option if you want to [protect your cloud resources from DDoS attacks](ddos-protection/index.md).
1. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

## Delete a subnet and static public IP address {#delete-resources}

If you no longer need a subnet, [delete it](operations/subnet-delete.md).

If the reserved address isn't assigned to any resource, you can [delete](operations/address-delete.md) it.

## What's next {#what-is-next}

[Create a new VM](../compute/operations/vm-create/create-linux-vm.md), connect it to a subnet, and assign it a reserved public IP address.