# Networking in {{ serverless-containers-name }}

By default, the container is launched in the isolated IPv4 network with the enabled [NAT gateway](../../vpc/concepts/gateways.md). For this reason, only public IPv4 addresses are available from the container.

## User network {#user-network}

{% include [note-preview](../../_includes/note-preview.md) %}

If necessary, you can specify a [cloud network](../../vpc/concepts/network.md#network) in container settings. In this case, it:

{% include [user-network](../../_includes/functions/user-network.md) %}

{% include [network](../../_includes/functions/network.md) %}

Regardless of the settings, any container is only invoked via a public API. You can't access the container from user resources. Learn more about [invoking a container](invoke.md).
