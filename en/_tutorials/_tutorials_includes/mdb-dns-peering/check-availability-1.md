* From the `cluster-vm` [virtual machine](../../../compute/concepts/vm.md) located in the same [cloud network](../../../vpc/concepts/network.md#network) as the cluster.

   The connection will be successful.
* From the `other-vm` virtual machine located in a different cloud network.

   The connection will fail because it will not be possible to get the [IP address](../../../vpc/concepts/address.md) of the cluster host using the [FQDN](../../../vpc/concepts/address.md#fqdn) from another network. However, you can [get the IP address](../../../vpc/operations/subnet-used-addresses.md) of the cluster host and use this IP address to connect: this connection will be successful.

   Next, we will demonstrate how to use shared [DNS zone](../../../dns/concepts/dns-zone.md) settings to maintain the ability to connect to a cluster from a different cloud network using FQDN.