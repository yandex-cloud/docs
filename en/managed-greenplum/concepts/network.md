# DB network and clusters

When creating a cluster, you can:

* Set the network and subnet for the cluster.
* Request public IP addresses to access the cluster from outside {{ yandex-cloud }}.

You can connect to a {{ mgp-short-name }} cluster only via the master hosts.

For high-speed communication between cluster hosts, {{ mgp-short-name }} uses a separate _an intra-cluster network_ (interconnect). Access to the intra-cluster network and direct connection to the host segments are not provided.

By default, master hosts are available for connection from VMs located in the same cloud network. [Learn more about networking](../../vpc/).

## Hostname and FQDN {#hostname}

When creating a cluster, {{ mgp-short-name }} assigns names of hosts automatically. You can't change short and full (FQDN) names of hosts.

You can use FQDN to access master hosts from both inside and outside {{ yandex-cloud }}.

## Public access to clusters {#public-access-to-a-host}

To get public IP addresses for accessing master hosts in the cluster from outside {{ yandex-cloud }}, enable the **Public access** option when creating a cluster. To connect to a cluster, use the FQDNs of its master hosts.

After creating a cluster, you cannot request or disable public addresses.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, be sure to [configure security groups](../operations/connect.md#configuring-security-groups) both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
