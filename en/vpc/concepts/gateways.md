# Gateways

## NAT gateway {#nat-gateway}

A _NAT gateway_ lets you grant internet access permissions to cloud resources without assigning them public IP addresses. Instead, they will access the internet via the NAT gateway that will be assigned an IP address from a separate range of public IPs. A gateway is a regional resource that is present in all availability zones. You can [manage gateways](../operations/create-nat-gateway.md) using the management console, CLI, Terraform, or API.

To route traffic through a gateway, specify it as the next hop in a [route table](static-routes.md). Currently, you can only use a NAT gateway for a route with the `0.0.0.0/0` destination prefix: any traffic to be routed outside the network will pass through this gateway.

If a VM's network interface is assigned a [public IP](address.md#public-addresses) and the subnet that this interface is connected to has a route table with a gateway set up, the VM will access the internet from that public IP and not through the gateway. Currently, you can't use reserved public IP addresses for gateways.

{% note warning %}

Please note that a NAT gateway will replace the [Egress NAT](../operations/enable-nat.md) function for subnets. If you disable NAT to the internet in a subnet, you can't enable it again and have to use a NAT gateway instead.

{% endnote %}


