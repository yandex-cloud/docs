# Networking in {{ dataproc-name }}

All subclusters of a cluster belong to the same [cloud network](../../vpc/concepts/network.md), while all hosts of each subcluster are in a certain subnet of that network.

When creating a cluster, public access can be enabled for any subcluster to make its hosts available online. You can only connect to subcluster hosts without public access through {{ yandex-cloud }} VMs located in the same cloud network as the cluster.

## Cluster host addresses {#hostname}

When you create a host in a subcluster, {{ dataproc-name }} generates a fully qualified domain name (FQDN) and IP address for it. You can use them to access the host within a single cloud network.

The host IP address may change during operation; however, its FQDN is permanent.

To learn how to get a host FQDN, see [this guide](../operations/connect.md#fqdn).

{% note warning %}

When you reduce the number of hosts in a subcluster, it is {{ dataproc-name }} that selects the hosts to remove. The FQDNs of the removed hosts stop working.

{% endnote %}

### Assigning network aliases to hosts {#fqdn-reconnect}

To maintain external network access to {{ dataproc-name }} services, create a network alias (`CNAME` record) in {{ dns-full-name }} to point to the relevant name of the {{ dataproc-name }} cluster master host.

To reconfigure external connections when recreating a cluster or moving the workload to a different cluster, you can just change the `CNAME` record you created.

For a configuration example, see the [Reconfiguring a network connection when recreating a cluster](../tutorials/reconnect-network.md) section.

## Security groups {#security-groups}

Security groups follow the _All traffic that is not allowed is prohibited_ principle. If the security group settings are missing the required rules, you will not be able to connect to the cluster. Furthermore, there will be no connectivity between the subclusters, the cluster, and the intermediate VM instance used for [port forwarding](interfaces.md).

For example, let's assume you use a VM located on the 10.128.0.0/16 subnet to connect to the cluster. If only the 10.133.0.0/24 subnet is specified in the security group rules, you will not be able to connect to the cluster. Moreover, you will not be able to connect to a cluster with a VM located in the 10.128.0.0/16 subnet, for which the permissions for the required ports have not been specified.

Before creating a cluster, you should create and configure security groups so that service traffic between cluster hosts is enabled. For more information, see [Creating a cluster](../operations/cluster-create.md).
