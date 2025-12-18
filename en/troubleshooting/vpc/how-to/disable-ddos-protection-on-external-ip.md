# How to disable DDoS protection


## Case description {#case-description}

You need to disable DDoS protection on an existing IP address.

## Solution {#case-resolution}

DDoS-protected IP addresses are issued from a separate IP pool. You cannot enable or disable DDoS protection on an external IP address that is already assigned to a VM. 

You can unassign the existing IP address from your VM and assign a new one, without DDoS protection. 

To do this, follow these steps in the [management console]({{ link-console-main }}):

1. Go to the VM settings page in the [management console]({{ link-console-main }}).
1. In the **{{ ui-key.yacloud.common.overview }}** tab, click ![***](../../../_assets/options.svg) in the top-right part of the **Network** sections.
1. Select **{{ ui-key.yacloud.compute.instance.overview.button_remove-public-ip }}**.
1. When the public IP is unassigned, repeat the action and select **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**.
1. In the pop-up window, do not enable **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**.

{% note alert %}

This will change the VM's public IP address, making it unavailable at the previous address.

{% endnote %}