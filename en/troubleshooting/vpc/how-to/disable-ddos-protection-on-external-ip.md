# How to disable DDoS protection

## Issue description {#case-description}
You need to disable DDoS protection on an existing IP.

## Solution {#case-resolution}
DDoS-protected IPs are issued from a separate IP pool.
You cannot disable or enable DDoS protection on an external IP already linked to a VM.
You can unlink the existing IP from your VM and link a new IP, without DDoS protection.

For this, in the management console, follow the steps:
1. Go to the VM properties page in the management console web interface.
2. On the overview tab, click the ellipsis icon (**"..."**) in the upper-right part of the **Network** section.
3. Select **"Disassociate public IP address"**.
4. When the public IP is removed, repeat the action and select "Add public IP address".
5. **Do not** select "DDoS protection" in the pop-up window.

{% note alert %}

Note that this action will change the VM's public IP, and it will no longer be available at this IP.

{% endnote %}
