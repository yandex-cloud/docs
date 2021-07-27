---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Cloud resource addresses

Addresses in cloud networks can be internal or public. Both internal and public addresses are assigned to cloud resources automatically.

## Internal addresses {#internal-addresses}

_Internal IP addresses_ are assigned to resources in the selected subnet of the folder where the resource is created. These addresses are used for transmitting information between the resources within your cloud.

An internal IP address can only be used to access the resources connected to the subnets of the same cloud network. The internal IP address does not change during the entire lifetime of the cloud resource.

## Public addresses {#public-addresses}

_Public IP addresses_ allow cloud resources to exchange data with the internet and resources from other cloud networks. Public addresses are mapped to internal resource addresses using one-to-one NAT.

{% include [public-ip-reset](../../_includes/public-ip-reset.md) %}

To prevent a public IP address from being reset or changed, you should [make it static](../operations/set-static-ip).

Unused static public IPs are charged [separately](../pricing).

## Hostname (FQDN) {#fqdn}

_You can use a hostname_ to access one cloud resource from another within the same cloud network.

The hostname is either set manually or generated automatically using the VM ID.

