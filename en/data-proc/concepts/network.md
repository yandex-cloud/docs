# Networks, clusters, and subclusters

All of the subclusters of a cluster are hosted in one network, and the host of each subcluster is hosted in a specific subnet of that network.

At the Preview stage, you cannot assign a public IP to a cluster host. To connect to a {{ dataproc-name }} cluster, create a VM in the same cloud network. [Learn more about networking in Yandex.Cloud](../../vpc/).

## Cluster host addresses {#hostname}

When you create a host in a subcluster, {{ dataproc-name }} generates a fully qualified domain name (FQDN) and IP address for it. You can use them to access the host within a single cloud network.

The host IP address may change during operation, its FQDN is always the same.

{% note important %}

When you reduce the number of hosts in a subcluster, the service selects the hosts to remove. The FQDNs of the removed hosts then no longer work.

{% endnote %}

