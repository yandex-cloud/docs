# Networking in {{ api-gw-name }}

By default, an API gateway is located in the isolated IPv4 network with the enabled [NAT gateway](../../vpc/concepts/gateways.md). For this reason, only public IPv4 addresses are accessible from it.

## User network

You can specify a [cloud network](../../vpc/concepts/network.md#network) in API gateway settings, if required. In this case, it will have access to the internet and user resources in the specified network, such as databases and VMs.

{% include [network](../../_includes/functions/network.md) %}

If the user specifies a network in the API gateway settings, this will create a subnet with addresses from the 198.19.0.0/16 range for each [availability zone](../../overview/concepts/geo-scope.md). The API gateway will be assigned an IP address from the respective subnet and will have access to all network resources.

{% include [network](../../_includes/functions/network-note.md) %}

To delete the network specified in the API gateway, delete all functions, containers, and API gateways it was set in and wait from 15 minutes to 24 hours.
