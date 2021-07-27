---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Networks, clusters, and subclusters

All of the subclusters of a cluster are hosted in one network, and the host of each subcluster is hosted in a specific subnet of that network.

You can't assign public IPs to cluster hosts. You can only connect to a {{ dataproc-name }} cluster using Yandex.Cloud VMs located in the same [cloud network](../../vpc/concepts/network.md) as the cluster.

## Cluster host addresses {#hostname}

When you create a host in a subcluster, {{ dataproc-name }} generates a fully qualified domain name (FQDN) and IP address for it. You can use them to access the host within a single cloud network.

The host IP address may change during operation, its FQDN doesn't.

{% note warning %}

When you reduce the number of hosts in a subcluster, the service selects the hosts to remove. The FQDNs of the removed hosts then no longer work.

{% endnote %}

