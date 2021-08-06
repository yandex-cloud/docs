# Cloud resource addresses

Addresses in cloud networks can be internal or public.

## Internal addresses {#internal-addresses}

_Internal IP addresses_ are assigned to resources in the selected subnet of the folder where the resource is created. These addresses are used for transmitting information between the resources within your cloud.

An internal IP address can only be used to access resources connected to subnets in the same cloud network. The internal IP address does not change during the entire lifetime of the cloud resource.

You can set internal IP addresses manually or automatically when creating a resource.

You can get a list of internal IP addresses that use cloud resources in the same subnet. For more information, see [{#T}](../operations/subnet-used-addresses.md).

## Public addresses {#public-addresses}

_Public IP addresses_ allow cloud resources to exchange data with the internet and resources from other cloud networks. Public addresses are mapped to internal resource addresses using one-to-one NAT. You can assign public addresses to resources automatically or select them from the list of reserved addresses.

Public IP addresses can be dynamic or static. When creating a cloud resource with a public IP, it's usually assigned a dynamic address. When a VM with a dynamic public IP is stopped, its address is released, and the next time the VM is started, it is assigned a new public IP address. When the VM is restarted, its public IP address is saved.

You can make a dynamic public IP address static. Static IP addresses do not change when resources are stopped and you can reserve them in your folder for future use even if they aren't linked to any cloud resources. To learn how to make a dynamic IP address static, see [{#T}](../../compute/operations/vm-control/vm-set-static-ip.md).

For more information about IP address pricing, see [{#T}](../pricing.md#prices-public-ip) in the {{ vpc-name }} documentation.

## Hostname (FQDN) {#fqdn}

You can use _a hostname_ to access one cloud resource from another within the same cloud network.

The hostname is either set manually or generated automatically using the VM ID.

For more information about how FQDNs are generated, see [Hostname and FQDN](../../compute/concepts/network.md#hostname) in the {{ compute-name }} documentation.

