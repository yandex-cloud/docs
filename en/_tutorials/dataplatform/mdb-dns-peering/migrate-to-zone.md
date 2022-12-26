DNS records for a cluster that existed before you [created a zone](#create-peering-zone) do not automatically migrate to this zone.

For the cluster's DNS records to migrate to the new zone, at least one DNS record has to be updated in the internal zones of the `cluster-net` and `vm-net` cloud networks.

For this to happen, for example, you can create a single virtual machine in each cloud network. You can delete these virtual machines after migrating the DNS records.


However, since [you already created virtual machines](#before-you-begin) called `cluster-vm` and `other-vm`, to achieve the desired effect, you only have to [stop and then restart](../../../compute/operations/vm-control/vm-stop-and-start.md) them.


When the migration process is complete, the cluster DNS records will appear in a zone named `vpc-peering-zone`.

{% note tip %}

Before migrating the DNS records of production clusters, migrate the records in the test folder containing the test cluster. This will help ensure that migration occurs without errors.

{% endnote %}