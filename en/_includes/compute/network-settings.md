* Enter a subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list.
   If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

   * In the window that opens, enter the network name and specify the folder to host the network.
   * (Optional) To automatically create subnets, select the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
   * Click **{{ ui-key.yacloud.component.vpc.create-network-dialog.button_create }}**.
    Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.

* In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, choose a method for assigning an IP address:

   * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP pool. With this, you can enable [DDoS protection](../../vpc/ddos-protection/index.md) using the option below.
   * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
   * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`: Do not assign a public IP address.

* In the **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** field, select the method for assigning internal addresses: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` or `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`.

* (Optional) Create records for the VM in the [DNS zone](../../dns/concepts/dns-zone.md):

   * Expand the **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** section and click **{{ ui-key.yacloud.dns.button_add-record }}**.
   * Specify the zone, FQDN, and TTL for the record. When setting the FQDN, you can select `{{ ui-key.yacloud.dns.label_auto-select-zone }}` for the zone.
      You can add multiple records to [internal DNS zones](../../dns/concepts/dns-zone.md). For more information, see [Cloud DNS integration with Compute Cloud](../../dns/concepts/compute-integration.md).
   * To create another record, click **{{ ui-key.yacloud.dns.button_add-record }}**.

* Select the [appropriate security groups](../../vpc/concepts/security-groups.md).
