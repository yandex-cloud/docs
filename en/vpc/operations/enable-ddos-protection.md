# Enable protection from DDoS attacks

DDoS protection activates when a virtual machine is [created](../../compute/quickstart/quick-create-linux) and public IPs are [reserved](get-static-ip.md).

Protected addresses are allocated from a separate pool; therefore, you cannot enable and disable protection for a previously reserved address.

## Enabling DDoS protection when creating a virtual machine {#enable-on-vm-creation}
{% list tabs %}

- Management console

   When configuring the network on a new virtual machine, select the automatically assigned public IP address or select an address from the list of reserved addresses.

   Once you select an address, select the **DDoS protection** option.

{% endlist %}

## Enabling DDoS protection when reserving IP addresses {#enable-on-reservation}

{% list tabs %}

- Management console

   To reserve a protected static IP address:

   1. In the [management console]({{ link-console-main }}), change to the folder where you need to reserve an address.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **IP addresses**.
   1. Click **Reserve address**.
   1. Select the availability zone where you want to reserve the address.
   1. Enable the **DDoS protection** option.
   1. Click **Reserve address**.

{% endlist %}
