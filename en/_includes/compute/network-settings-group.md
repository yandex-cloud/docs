* Enter a subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list.
   If you do not have a network, click **{{ ui-key.yacloud.compute.instances.create.button_net_empty-create }}** to create one:

   * In the window that opens, enter a name for your network.
   * (Optional) To automatically create subnets, select the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
   * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

  Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.compute.instances.create.button_create-subnetwork-new }}**.

* In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, choose a method for assigning an IP address:

   * `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP pool.
   * `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`: Do not assign a public IP address.

* Select the [appropriate security groups](../../vpc/concepts/security-groups.md).

* (Optional) Create records for the VM in the [DNS zone](../../dns/concepts/dns-zone.md):

   * Expand the **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** section and click **{{ ui-key.yacloud.dns.button_add-record }}**.
   * Specify the zone, FQDN, and TTL for the record. When setting the FQDN, you can select `{{ ui-key.yacloud.dns.label_auto-select-zone }}` for the zone.
      You can add multiple records to [internal DNS zones](../../dns/concepts/dns-zone.md). For more information, see [Cloud DNS integration with Compute Cloud](../../dns/concepts/compute-integration.md).
