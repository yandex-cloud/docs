# Network in {{ dataproc-name }}

All subclusters of a cluster belong to the same [cloud network](../../vpc/concepts/network.md), while all hosts of each subcluster are in a certain subnet of that network.

When creating a cluster, any host can be assigned a public IP address, which will make the cluster available online. You can connect to hosts without a public IP address only through {{ yandex-cloud }} virtual machines located on the same cloud network as the cluster.

## Cluster host addresses {#hostname}

When you create a host in a subcluster, {{ dataproc-name }} generates a fully qualified domain name (FQDN) and IP address for it. You can use them to access the host within a single cloud network.

The host IP address may change during operation; however, its FQDN is permanent.

{% note warning %}

When you reduce the number of hosts in a subcluster, the service selects the hosts to remove. The FQDNs of the removed hosts stop working.

{% endnote %}

## Security groups {#security-groups}

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

Security groups follow the "All traffic that is not allowed is prohibited" principle. If the security group settings are missing the required rules, you will not be able to connect to the cluster. Furthermore, there will be no connectivity between the subclusters, the cluster, and the intermediate VM instance used for [port forwarding](interfaces.md).

For example, let's assume a VM located on the 10.128.0.0/16 subnet is used to connect to the cluster. If only the 10.133.0.0/24 subnet is specified in the security group rules, you will not be able to connect to the cluster. Moreover, you will not be able to connect to a cluster with a VM located in the 10.128.0.0/16 subnet, which the permissions for the required ports have not been specified for.

Before creating a cluster, you should create and configure security groups so that service traffic between cluster hosts is enabled. For more information, see [{#T}](../operations/cluster-create.md).
