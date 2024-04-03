Clients (such as [virtual machines](../../../compute/concepts/vm.md)) in the same [cloud network](../../../vpc/concepts/network.md#network) as the cluster can access cluster hosts using their fully qualified domain names ([FQDNs](../../../vpc/concepts/address.md#fqdn)). However, if the clients are in another cloud network, this will not be possible. This is because the required [DNS service zones](../../../dns/concepts/dns-zone.md#service-zones) are created automatically and only support name resolution within a single cloud network.

[{{ dns-full-name }}](../../../dns/) enables you to configure a [DNS zone](../../../dns/concepts/dns-zone.md) shared by multiple cloud networks. This makes it possible to access cluster hosts by their FQDNs even if the client and the cluster are on different cloud networks.

{% note warning %}

Cluster hosts with public access enabled will become inaccessible by their FQDNs from within the cloud networks with the shared DNS zone. However, such hosts will still be accessible by their FQDNs from the internet.

{% endnote %}

To set up a shared DNS zone:
1. [Create a zone in {{ dns-name }}](#create-peering-zone).
1. [Make sure the DNS records migrate to the zone](#do-actions-for-migration).
1. [Check cluster availability](#check-cluster-availability).

If you no longer need the resources you created, [delete them](#clear-out).

The following is an example where:
1. The `cluster-net` cloud network hosts a cluster and the `cluster-vm` virtual machine.
1. You create a new cloud network called `vm-net` with a VM named `other-vm`.
1. You test cluster accessibility from these VMs.
1. You create a DNS zone called `vpc-peering-zone` and perform migration.
1. You test cluster accessibility from these VMs once again.