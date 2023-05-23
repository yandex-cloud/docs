# Networking in {{ api-gw-name }}

By default, an API gateway is located in the isolated IPv4 network with the enabled [NAT gateway](../../vpc/concepts/gateways.md). For this reason, only public IPv4 addresses are accessible from it.

## User network

{% include [note-preview](../../_includes/note-preview.md) %}

You can specify a [cloud network](../../vpc/concepts/network.md#network) in API gateway settings, if required. In this case, the gateway will:

* Be hosted in the specified cloud network.
* Have access to the internet and user resources in the specified network, such as databases and VMs.
* Have an IP address within the `198.19.0.0/16` range when accessing user resources.

{% include [network](../../_includes/functions/network.md) %}
