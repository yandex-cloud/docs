# DNS resolver

When creating a new [subnet](../../vpc/concepts/network.md#subnet) in a [cloud network (VPC)](../../vpc/concepts/network.md#network), the second IP address from the beginning in this subnet (e.g., `.2`) is always reserved for the *DNS resolver*, which processes DNS requests from resources connected to this subnet.

When creating a VM in a subnet, the resolver IP address is sent to the new VM together with other network interface parameters via DHCP. This IP address is used by the VM internally as the DNS server address.

The IP connectivity from the VM to the resolver is contributed by a special component called [VRouter-agent](../../vpc/concepts/network-overview.md#vrouter-agent) accessible only inside the VM and not from the outside. To integrate corporate DNS services associated with cloud resources, you need to [deploy and configure a VM with the DNS Forwarder feature](../tutorials/dns-integration.md).
