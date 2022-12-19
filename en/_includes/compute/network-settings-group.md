* Enter a subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list.
   If you don't have a network, click **Create network** to create one:

   * In the window that opens, enter the network name and folder to host the network.
   * (optional) To automatically create subnets, select the **Create subnets** option.
   * Click **Create**.
   Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **Create subnet**.

* In the **Public IP** field, choose a method for assigning an IP address:

   * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
   * **No address**: Don't assign a public IP address.

* Select [appropriate security groups](../../vpc/concepts/security-groups.md) (if there is no corresponding field, the virtual machine will be enabled for all incoming and outgoing traffic).

* (optional) Create records for the VM in the [DNS zone](../../dns/concepts/dns-zone.md):

   * Expand **DNS settings for internal addresses** and click **Add record**.
   * Specify the zone, FQDN, and TTL for the record. When setting the FQDN, you can select **Detect automatically** for the zone.
      You can add multiple records to [internal DNS zones](../../dns/concepts/dns-zone.md). For more information, see [Cloud DNS integration with Compute Cloud](../../dns/concepts/compute-integration.md).