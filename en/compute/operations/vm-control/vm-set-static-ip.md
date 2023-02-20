# Converting a VM's public IP address to static

A _static IP address_ is a permanent IP address that does not change when a VM is stopped.

### Use of static IP addresses {#use-of-static-IP-addresses}


Public static IP addresses are charged at an individual rate. For more information, see [{#T}](../../../vpc/pricing.md#prices-public-ip) in the {{ vpc-name }} documentation.


To make a VM's public IP address static:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Select the VM.
   1. Specify the VM's public IP address. You can find out the IP address in the **Network** section on the VM's page.
   1. Make the public IP address static. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md) in the {{ vpc-name }} documentation.

{% endlist %}
