* Enter a subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list.
   If you do not have a network, click **Create network** to create one:

   * In the window that will show up, enter the network name and specify the folder to host the network.
   * (optional) To automatically create subnets, select the **Create subnets** option.
   * Click **Create**.
   Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **Add subnet**.

* In the **Public IP** field, choose a method for assigning an IP address:

   * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool. {% if product == "yandex-cloud" %}With this, you can enable [DDoS protection](../../vpc/ddos-protection/index.md) using the option below.{% endif %}
   * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
   * **No address**: Don't assign a public IP address.

* In the **Internal address** field, select the method for assigning internal addresses: **Auto** or **Manual**.

* (optional) Create records for the VM in the [DNS zone](../../dns/concepts/dns-zone.md):

   * Expand **DNS settings for internal addresses** and click **Add record**.
   * Specify the zone, FQDN, and TTL for the record. When setting the FQDN, you can select **Detect automatically** for the zone.
      You can add multiple records to [internal DNS zones](../../dns/concepts/dns-zone.md). For more information, see [Cloud DNS integration with Compute Cloud](../../dns/concepts/compute-integration.md).

* Select [appropriate security groups](../../vpc/concepts/security-groups.md) (if there is no such field, the virtual machine will be enabled for all incoming and outgoing traffic).
