{% if audience != "internal" %}

Clients (such as virtual machines) on the same [cloud network](../../../vpc/concepts/network.md#network) as the cluster can access cluster hosts by their Fully Qualified Domain Names (FQDNs). However, if the clients are on another cloud network, this will not be possible. This is because the required [DNS service zones](../../../dns/concepts/dns-zone.md#service-zones) are created automatically and only support name resolution within a single cloud network.

{% else %}

Clients (such as virtual machines) on the same cloud network as the cluster can access cluster hosts by their Fully Qualified Domain Names (FQDNs). However, if the clients are on another cloud network, this will not be possible. This is because the required DNS service zones are created automatically and only support name resolution within a single cloud network.

{% endif %}

{{ dns-full-name }} enables you to configure a DNS zone shared by multiple cloud networks. This makes it possible to access cluster hosts by their FQDNs even if the client and the cluster are on different cloud networks.

{% note warning %}

Cluster hosts with public access enabled will become inaccessible by their FQDNs from within the cloud networks with the shared DNS zone. However, such hosts will still be accessible by their FQDNs from the internet.

{% endnote %}

To set up a shared DNS zone:

1. [Create a zone in {{ dns-full-name }}](#create-peering-zone).
1. [Make sure the DNS records migrate to the zone](#do-actions-for-migration).
1. [Check cluster availability](#check-cluster-availability).

If you no longer need the created resources, [delete them](#clear-out).

The following is an example where:

1. The `cluster-net` cloud network hosts a cluster and the `cluster-vm` virtual machine.
1. You create a new cloud network called `vm-net` with a virtual machine named `other-vm`.
1. You use these VMs to test cluster availability.
1. You create a DNS zone called `vpc-peering-zone` and perform migration.
1. You test cluster availability from these VMs again.
