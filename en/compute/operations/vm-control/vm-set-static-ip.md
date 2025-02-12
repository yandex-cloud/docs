# Making a VM public IP address static

A _static IP address_ is a permanent IP address that remains unchanged when a VM is stopped.

### Using static IP addresses {#use-of-static-IP-addresses}


Public static IP addresses are charged at an individual rate. For more information, see [{#T}](../../../vpc/pricing.md#prices-public-ip) in the {{ vpc-name }} documentation.


To make a public IP address assigned to a VM [network interface](../../concepts/network.md) static:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Select the VM.
  1. Get the VM public IP address. You can find it in the **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** field of the relevant interface section under **{{ ui-key.yacloud.compute.instance.overview.section_network }}** on the VM page.
  1. Make the public IP address static. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md) in the {{ vpc-name }} documentation.

{% endlist %}