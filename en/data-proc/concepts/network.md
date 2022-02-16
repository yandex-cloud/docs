# Networks, clusters, and subclusters

All of the subclusters of a cluster are hosted in one network, and the host of each subcluster is hosted in a specific subnet of that network.

The host of the main subcluster can have a public IP address, which means you can connect to the cluster over the internet. Connecting to hosts of other {{ dataproc-name }} subclusters is possible only from {{ yandex-cloud }} VMs located in the same [cloud network](../../vpc/concepts/network.md) as the cluster.

## Cluster host addresses {#hostname}

When you create a host in a subcluster, {{ dataproc-name }} generates a fully qualified domain name (FQDN) and IP address for it. You can use them to access the host within a single cloud network.

The host IP address may change during operation, its FQDN doesn't.

{% note warning %}

When you reduce the number of hosts in a subcluster, the service selects the hosts to remove. The FQDNs of the removed hosts then no longer work.

{% endnote %}

## Security groups {#security-groups}

Security groups follow the principle "All traffic that is not allowed is prohibited". If the necessary rules aren't in the security group settings, you won't be able to connect to the cluster. Also, data exchange between the subclusters, cluster, and intermediate VM used for [port forwarding](interfaces.md) won't be supported.

For example, let's assume a VM located on the 10.128.0.0/16 subnet is used to connect to the cluster. If only the 10.133.0.0/24 subnet is specified in the security group rules, you won't be able to connect to the cluster. Moreover, you won't be able to connect to a cluster with a VM located in the 10.128.0.0/16 subnet, which the permissions for the necessary ports haven't been specified for.

Before creating a cluster, you should create and configure security groups so that service traffic between cluster hosts is enabled. For more information, see [{#T}](../operations/cluster-create.md).
