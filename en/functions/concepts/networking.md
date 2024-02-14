# Networking in {{ sf-name }}

By default, the function is launched in the isolated IPv4 network with the enabled [NAT gateway](../../vpc/concepts/gateways.md). For this reason, only public IPv4 addresses are available.

## User network {#user-network}

If necessary, you can specify a [cloud network](../../vpc/concepts/network.md#network) in function settings. In this case, the function will have access to the internet and user resources in the specified network, such as databases and VMs.

{% include [network](../../_includes/functions/network.md) %}

If the user specifies a network in the function settings, this will create a service subnet with addresses from the 198.19.0.0/16 range for each [availability zone](../../overview/concepts/geo-scope.md). Once run, the function will be assigned an IP address from the respective subnet and will have access to all network resources.

{% include [network](../../_includes/functions/network-note.md) %}

Networking between two functions and between functions and user resources is limited:
* Outbound connections over TCP, UDP, and ICMP are supported. For example, a function may access a {{ compute-name }} VM or {{ ydb-name }} database in the user network.
* Inbound connections are not supported. For example, there is no way to access internal function components over the network even if you know the IP address of its instance.

It may take longer than usual to run a new instance of the function whose settings specify the network. Regardless of the settings, any function is called only via the public API. More about [function calls](function-invoke.md).

To delete the network specified in the function, delete all the functions, containers, and API gateways it was set in and wait from 15 minutes to 24 hours.
