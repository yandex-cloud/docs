Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

* In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, select a [cloud network](../../../vpc/concepts/network.md#network) from the list.

    * Each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet). If your network has no subnets, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
    * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

        * In the window that opens, specify the network name and select the folder to host the network.
        * Optionally, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** setting to automatically create subnets in all availability zones.
        * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

* In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select an IP address assignment method:

    * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`: To assign a random IP address from the {{ yandex-cloud }} IP address pool. In this case, you can enable [DDoS protection](../../../vpc/ddos-protection/index.md) using the option below.
    * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`: To select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
    * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`: Not to assign a public IP address.

* Select the [relevant security groups](../../../vpc/concepts/security-groups.md). If you leave this field empty, the default security group will be assigned to the VM.

* Expand **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** and select a method for assigning internal addresses in the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field:

    * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`: To assign a random IP address from the pool of IP addresses available in the selected subnet.
    * `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`: To manually assign a private IP address to the VM.
    * Enable **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**, if required. The option is available if you previously selected the automatic IP assignment method in the public address settings.

* Optionally, create records for your VM in the [DNS zone](../../../dns/concepts/dns-zone.md):

    * Expand **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** and click **{{ ui-key.yacloud.dns.button_add-record }}**.
    * Specify a zone, FQDN, and TTL for the record. When setting the FQDN, you can enable `{{ ui-key.yacloud.dns.label_auto-select-zone }}` for the zone.
      You can add multiple records to [internal DNS zones](../../../dns/concepts/dns-zone.md). For more information, see [Cloud DNS integration with Compute Cloud](../../../dns/concepts/compute-integration.md).
    * To create another record, click **{{ ui-key.yacloud.dns.button_add-record }}**.

If you want to add another [network interface](../../../compute/concepts/network.md) to your VM, click **{{ ui-key.yacloud.compute.instances.create.label_add-network-interface }}** and repeat the settings from this step for the new interface. You can add up to eight network interfaces to a single VM.