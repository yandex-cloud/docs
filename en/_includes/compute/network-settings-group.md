* Specify the subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list.
  If there are no networks in the list, click **{{ ui-key.yacloud.compute.instances.create.button_net_empty-create }}** to create one:

    * In the window that opens, enter a name for your network.
    * Optionally, to automatically create subnets, enable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

  Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If your network has no subnets, create one by selecting **{{ ui-key.yacloud.compute.instances.create.button_create-subnetwork-new }}**.

* In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select a method for assigning an IP address:

    * `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`: To assign a random IP address from the {{ yandex-cloud }} IP address pool.
    * `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`: Not to assign a public IP address.

* Select the [relevant security groups](../../vpc/concepts/security-groups.md).

* Optionally, create records for your VM in the [DNS zone](../../dns/concepts/dns-zone.md):

    * Expand **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** and click **{{ ui-key.yacloud.dns.button_add-record }}**.
    * Specify a zone, FQDN, and TTL for the record. When setting the FQDN, you can enable `{{ ui-key.yacloud.dns.label_auto-select-zone }}` for the zone.
      You can add multiple records to [internal DNS zones](../../dns/concepts/dns-zone.md). For more information, see [Cloud DNS integration with Compute Cloud](../../dns/concepts/compute-integration.md).
