# Networking in {{ sf-name }}

By default, the function is launched in the isolated IPv4 network with the enabled [NAT gateway](../../vpc/concepts/gateways.md). For this reason, only public IPv4 addresses are available.

## User network {#user-network}

{% include [note-preview](../../_includes/note-preview.md) %}

If necessary, you can specify a [cloud network](../../vpc/concepts/network.md#network) in function settings. In this case, the function:

{% include [user-network](../../_includes/functions/user-network.md) %}

{% include [network](../../_includes/functions/network.md) %}

Regardless of the settings, any function is called only via the public API. You can't access the function from user resources. More about [function calls](function-invoke.md).
