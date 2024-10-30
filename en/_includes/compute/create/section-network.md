Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

* In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, you can select a [cloud network](../../../vpc/concepts/network.md#network) from the list.

    * Each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
    * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

        * In the window that opens, enter the network name and select the folder to host the network.
        * (Optional) Select the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option to automatically create subnets in all availability zones.
        * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

* In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, choose a method for assigning an IP address:

    * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP address pool. In this case, you can enable [DDoS protection](../../../vpc/ddos-protection/index.md) using the option below.
    * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
    * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`: Do not assign a public IP address.

* Select the [appropriate security groups](../../../vpc/concepts/security-groups.md). If you leave this field empty, the default security group will be assigned to the VM.

* Expand the **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** section and select a method for internal IP address assignment in the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field:

    * `{{ ui-key.yacloud.common.label_auto }}`: Assign a random IP address from the pool of IP addresses available in the selected subnet.
    * `{{ ui-key.yacloud.common.label_list }}`: Select a private IP address from the list of previously reserved IP addresses. Click **{{ ui-key.yacloud.component.internal-v4-address-field.button_internal-address-reserve }}** to reserve a private IP address in the selected subnet if needed.
    * Enable the **{{ ui-key.yacloud.common.field_ddos-protection-provider }}** option, if needed. The option is available if you previously selected the automatic IP assignment method in the public address settings.

* (Optional) Create records for the VM in the [DNS zone](../../../dns/concepts/dns-zone.md):

    * Expand the **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** section and click **{{ ui-key.yacloud.dns.button_add-record }}**.
    * Specify the zone, FQDN, and TTL for the record. When setting the FQDN, you can select `{{ ui-key.yacloud.dns.label_auto-select-zone }}` for the zone.
      You can add multiple records to [internal DNS zones](../../../dns/concepts/dns-zone.md). For more information, see [Cloud DNS integration with Compute Cloud](../../../dns/concepts/compute-integration.md).
    * To create another record, click **{{ ui-key.yacloud.dns.button_add-record }}**.

If you want to attach an additional [network interface](../../../compute/concepts/network.md) to your VM, click **{{ ui-key.yacloud.compute.instances.create.label_add-network-interface }}** and repeat the settings from this step for the new interface. You can add up to eight network interfaces to a single VM.