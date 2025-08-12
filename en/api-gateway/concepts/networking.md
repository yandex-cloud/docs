# Networking in {{ api-gw-name }}

By default, an API gateway resides in an isolated IPv4 network with a [NAT gateway](../../vpc/concepts/gateways.md) enabled. For this reason, it can only access public IPv4 addresses.

## User network {#user-network}

You can specify a [cloud network](../../vpc/concepts/network.md#network) in API gateway settings, if required. In this case, it will have access to the internet and user resources in the specified network, such as databases and VMs.

{% include [network](../../_includes/functions/network.md) %}

If you specify a network in the API gateway settings, this will create a subnet with addresses from the 198.19.0.0/16 range in each [availability zone](../../overview/concepts/geo-scope.md). The API gateway will get an IP address from the respective subnet and will have access to all network resources.

To delete the network specified in the API gateway, delete all the functions, containers, and API gateways it is set in and wait from 15 minutes to 24 hours.
