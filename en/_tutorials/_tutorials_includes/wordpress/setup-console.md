1. [Prepare your cloud](#before-you-begin).
1. [Create a security group](#create-security-group).
1. [Create a VM for WordPress](#create-vm).
1. [Configure DNS (if you have a domain name)](#configure-dns).
1. [Configure WordPress](#wordpress-config).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

{% include [network-is-exist](../../_tutorials_includes/network-is-exist.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources-wp](../../_tutorials_includes/wordpress/paid-resources-wp.md) %}

## Create a security group {#create-security-group}

To create a [security group](../../../vpc/concepts/security-groups.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Open the **Security groups** tab.
   1. Click **Create group**.
   1. Enter the **name** of the group: `wordpress`.
   1. Select the **Network**.
   1. Under **Rules**, create the following rules using the instructions below the table:

      | Traffic<br>direction | Description | Port<br>range | Protocol | Source/<br>destination type | Source /<br>destination |
      --- | --- | --- | --- | --- | ---
      | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
      | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
      | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |

      1. Select the **Outgoing traffic** or **Incoming traffic** tab.
      1. Click **Add rule**.
      1. In the **Port range** window that opens, specify the port to receive traffic. Do not indicate anything for outgoing traffic.
      1. In the **Protocol** field, specify the required protocol. For outgoing traffic, leave **Any** to allow traffic over all protocols.
      1. In the **Destination** or **Source** field, select the **CIDR**, and the rule is applied to a range of IP addresses. In the **CIDR bloсks** field, enter `0.0.0.0/0`.
      1. Click **Save**. Repeat the steps to create all the rules from the table.
   1. Click **Save**.

{% endlist %}

## Create a VM for WordPress {#create-vm}

To create a VM:

{% list tabs group=instructions %}

- Management console {#console}

   1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

      ![create-vm](../../../_assets/tutorials/wordpress/vm-create-1.png)

   1. In the **Name** field, enter `wordpress` as the VM name. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Select an availability zone to place your VM in.
   1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab and select [WordPress](../../../marketplace/products/yc/wordpress) as your public image.

      ![choose-image](../../../_assets/tutorials/wordpress/vm-create-3.png)

   1. Under **Computing resources**:
      * Choose a [platform](../../../compute/concepts/vm-platforms.md).
      * Specify the required number of vCPUs and the amount of RAM.

      The minimum configuration is enough for testing:
      * **Platform**: Intel Ice Lake
      * **vCPU**: 2
      * **Guaranteed vCPU share**: 20%
      * **RAM**: 1 GB
   1. In **Network settings**, select the subnet to connect the VM to once it is created.
   1. In **Public address**, select **Automatically**.

      ![choose-network](../../../_assets/tutorials/wordpress/vm-create-4.png)

   1. In **Security group**, select the `wordpress` group.
   1. Specify the VM access data:
      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the public key file.

         You will need to create a key pair for the SSH connection yourself. For more information, see [{#T}](../../../compute/operations/vm-connect/ssh.md).
   1. Click **Create VM**.

   It may take a few minutes to create a VM. When the VM's status changes to `RUNNING`, you can begin configuring the website.

   Once created, the VM is assigned an IP address and a [host name (FQDN)](../../../compute/concepts/network.md#hostname). This data can be used when configuring the DNS and SSH access.

{% endlist %}

## Configure the DNS (if you have a domain name) {#configure-dns}

If you have a registered domain name, use the [{{ dns-full-name }}](../../../dns/) service to manage the domain.

{% include [configure-a-record-and-cname](../../_tutorials_includes/configure-a-record-and-cname.md) %}

## Configure WordPress {#wordpress-config}

To configure WordPress:

{% list tabs group=instructions %}

- Management console {#console}

   {% include [wordpress-config](wordpress-config.md) %}

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../../compute/operations/vm-control/vm-delete.md) the `wordpress` VM.
1. [Delete](../../../vpc/operations/address-delete.md) the static public IP address if you reserved one specifically for this VM.
1. [Delete](../../../dns/operations/resource-record-delete.md) the DNS records and [delete](../../../dns/operations/zone-delete.md) the DNS zone if you used {{ dns-name }}.
