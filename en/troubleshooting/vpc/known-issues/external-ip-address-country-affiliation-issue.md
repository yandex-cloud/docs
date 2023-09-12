# Errors in geographic attribution of Yandex Cloud resource IP addresses

## Issue description {#issue-description}

- Governmental sites are blocking connections originating from the VM, considering that the originating IP address is outside Russia.
- Based on the information from third-party online resources, the external IP address belongs to another country.

## Solution {#issue-resolution}

All external IP ranges in Yandex Cloud are located in Russia.
However, the information on IP ranges is distributed over the internet, and some companies may sometimes fail to timely update their IP attribution data.

If needed, you can get another public IP for your VM. For this, stop the VM in the Yandex Cloud console, and then restart it. If the VM parameters use a dynamic public IP, when you stop and then start such a VM, it gets a new IP. You can make this IP static if needed. A static IP address will not change when you stop your VM.

{% note info %}

Public IP ranges for Yandex Cloud are listed [here](../../../vpc/concepts/ips.md). To check the country of your IP, use the `whois` command or the [RIPE](https://apps.db.ripe.net/db-web-ui/query) public resource.

{% endnote %}

You can also try moving your VM to a different availability zone. For this, follow this [guide](../../../compute/operations/vm-control/vm-change-zone.md).

To make a VM's public IP address static, do the following:
1. When your VM is running, in the cloud console, click "Virtual Private Cloud".
2. Go to "IP addresses".
2. Find the IP address in the list.
3. On the right of the IP line, click "...".
4. In the menu that opens, select **Make static**.

For more information, see the [documentation section](../../../vpc/operations/set-static-ip.md).
