# Cloud resource addresses

In cloud networks, addresses can be internal or public.

## Internal addresses {#internal-addresses}

_Internal IP addresses_ are assigned to resources in the selected subnet of the folder where the resource is created. These addresses are used for transmitting information between the resources within your cloud.

An internal IP address can only be used to access resources connected to subnets in the same cloud network. The internal IP address does not change during the entire lifetime of the cloud resource.

You can set internal IP addresses manually or automatically when creating a resource.

You can get a list of internal IP addresses that use cloud resources in the same subnet. For more information, see [{#T}](../operations/subnet-used-addresses.md).

## Public addresses {#public-addresses}

_Public IP addresses_ allow cloud resources to exchange data with the internet and resources from other cloud networks. Public addresses are mapped to internal resource addresses using one-to-one NAT. You can assign public addresses to resources automatically or select them from the list of reserved addresses.

Public IP addresses can be dynamic or static. When creating a cloud resource with a public IP, it is usually assigned a dynamic address. When a VM with a dynamic public IP is stopped, its address is released, and it gets a new public IP address when started next time. When the VM is restarted, its public IP address is saved.

You can convert a dynamic public IP address to static. Static IP addresses do not change when resources are stopped, and you can reserve them in your folder for future use even if they are not linked to any cloud resources. To learn how to convert a dynamic IP address to static, see [{#T}](../../compute/operations/vm-control/vm-set-static-ip.md).

{% include notitle [note-public-ip-traffic.md](../../_includes/pricing/note-public-ip-traffic.md) %}


For more information about IP address pricing, see the [{#T}](../pricing.md#prices-public-ip) section of the {{ vpc-name }} documentation.



### Outgoing traffic from TCP port 25 {#port-25}

{% include [port-25.md](../../_includes/vpc/port-25.md) %}

## Hostname (FQDN) {#fqdn}

You can use a _host name_ to access one cloud resource from another within the same cloud network.

The host name is either set manually or generated automatically using the VM ID.

For more information about how FQDNs are generated, see the [Host name and internal FQDN](../../compute/concepts/network.md#hostname) section in the {{ compute-name }} documentation.
