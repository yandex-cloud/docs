# Errors in geographic attribution of {{ yandex-cloud }} resource IP addresses


## Issue description {#issue-description}

* Government websites block VM connections, treating the source IP address as non-Russian.
* Based on the information from third-party online resources, the external IP address belongs to another country.

## Solution {#issue-resolution}

All {{ yandex-cloud }} external IP address ranges are registered in Russia. However, the information on IP address ranges is communicated over the internet, and some companies may sometimes fail to timely update their IP attribution data.

If required, you can get another public IP address for your VM. To do this, stop the VM in the [management console]({{ link-console-main }}), and then restart it. If the VM uses a dynamic public IP, it will get a new one once you stop and then start it. You can configure your VM to use a static IP address, if required. In this case, it will not change after the VM restarts.

{% note info %}

{{ yandex-cloud }} public IP address ranges are listed [here](../../../vpc/concepts/ips.md). To check the country of your IP address, use the `whois` command or the [RIPE](https://apps.db.ripe.net/db-web-ui/query) public resource.

{% endnote %}

You can also try moving your VM to a different availability zone. For this, follow [this guide](../../../compute/operations/vm-control/vm-change-zone.md).

To convert your VM's public IP address to static, do the following:

1. While your VM is running, navigate to **{{ ui-key.yacloud.component.navigation-menu.label_vpc }}** in the cloud console.
1. Go to **{{ ui-key.yacloud.vpc.addresses.label_title }}**.
1. Find the IP address in the list.
1. Click ![***](../../../_assets/options.svg) next to the IP address.
1. In the drop-down menu, select **{{ ui-key.yacloud.vpc.addresses.button_action-static }}**. 

To learn more, see [this guide](../../../vpc/operations/set-static-ip.md).