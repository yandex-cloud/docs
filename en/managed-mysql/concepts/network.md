# Network and clusters in {{ mmy-name }}

{% if audience != "internal" %}

When creating a cluster, you can:

* Set the network for the cluster itself.
* Set the subnets for each host in the cluster.
* Request a public IP address to access the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

{% else %}

{% include notitle [Internal access](../../_includes/mdb/internal-access.md) %}

{% endif %}

## Hostname and FQDN {#hostname}

{{ mmy-short-name }} generates the name of each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network. Read more in the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating or editing the host. To connect to this kind of host, use its FQDN.

When deleting a host with a public FQDN, the assigned IP address is revoked.

{% endif %}

## Connecting to cluster hosts {#cluster-connect}

You can [connect to {{ mmy-short-name }} cluster hosts](../operations/connect.md):

{% include [cluster-connect-note](../../_includes/mdb/mmy/cluster-connect-note.md) %}

The maximum number of connections is defined by the [max_connections](./settings-list.md#setting-max-connections) setting, which [depends on the host class](./settings-list.md#settings-instance-dependent).

In addition to host names, to connect to a cluster, you can use [special FQDNs](../operations/connect.md#special-fqdns) that indicate the current master host and the replica that is least lagging from it.

{% if audience != "internal" %}

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, be sure to [configure](../operations/connect.md#configure-security-groups) security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

{% endif %}
