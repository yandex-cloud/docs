DNS records for a cluster that existed before you [created a DNS zone](#create-peering-zone) do not automatically migrate to this [DNS zone](../../../dns/concepts/dns-zone.md).

For the cluster's DNS records to migrate to the new DNS zone, at least one DNS record must be updated in the internal zones of the `cluster-net` and `vm-net` [cloud networks](../../../vpc/concepts/network.md#network).

You can achieve this, for example, by creating a single [virtual machine](../../../compute/concepts/vm.md) in each cloud network. You can delete these VMs after migrating the DNS records.

However, since [you already created the `сluster-vm` and `other-vm` virtual machines](#before-you-begin), you only have to [stop and then restart](../../../compute/operations/vm-control/vm-stop-and-start.md) them.

When the migration process is complete, the cluster DNS records will appear in the `vpc-peering-zone` DNS zone.

{% note tip %}

Before migrating the DNS records of production clusters, migrate the records in the test folder containing the test cluster. This will help ensure that migration occurs without errors.

{% endnote %}