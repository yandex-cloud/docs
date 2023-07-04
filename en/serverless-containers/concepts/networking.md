# Networking in {{ serverless-containers-name }}

By default, the container is launched in the isolated IPv4 network with the enabled [NAT gateway](../../vpc/concepts/gateways.md). For this reason, only public IPv4 addresses are available from the container.

## User network {#user-network}

{% include [note-preview](../../_includes/note-preview.md) %}

If necessary, you can specify a [cloud network](../../vpc/concepts/network.md#network) in container settings. In this case, it will have access to the internet and user resources in the specified network, such as databases and VMs.

{% include [network](../../_includes/functions/network.md) %}

If the user specifies a network in the container settings, each [availability zone](../../overview/concepts/geo-scope.md) will have a service subnet created with IP addresses from the 198.19.0.0/16 range. Once run, the container will be assigned an IP address from the respective subnet and will have access to all network resources.

{% include [network](../../_includes/functions/network-note.md) %}

Networking between two containers and between containers and user resources is limited:
* Outbound connections over TCP, UDP, and ICMP are supported. For example, a container may access a {{ compute-name }} VM or {{ ydb-name }} database in the user network.
* Inbound connections are not supported. For example, there is no way to access the application port inside a container even if you know the IP address of a container instance.

It may take longer than usual to run a new instance of the container whose settings specify the network. Regardless of the settings, any container is only invoked via a public API. Learn more about [invoking a container](invoke.md).

To delete the network specified in the container, delete all the functions, containers, and API gateways it was set in and wait from 15 minutes to 24 hours.
