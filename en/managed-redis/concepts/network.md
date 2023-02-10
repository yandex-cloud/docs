# {{ mrd-short-name }} network and DB clusters

{% if audience != "internal" %}

 When creating a cluster, you can:

* Set the network for the cluster itself.
* Set the subnets for each host in the cluster.
* Enable TLS support. You need TLS support if you plan to connect to cluster hosts from the Internet.

{% else %}

{% include notitle [Internal access](../../_includes/mdb/internal-access.md) %}

{% endif %}

## Hostname and FQDN {#hostname}

{{ mrd-short-name }} generates a name for each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network.

## Public access to {#public-access-to-host} cluster hosts

If you create a {{ mrd-short-name }} cluster with TLS support, you can connect to it both from a {{ yandex-cloud }} VM and from the Internet.

If you created a cluster without TLS support, you can only connect to it from a {{ yandex-cloud }} VM on the same cloud network. You cannot get a public IP address for a host in this type of cluster.

Any host in a cluster with TLS support enabled can be available from outside {{ yandex-cloud }} if you requested public access when [creating](../operations/hosts.md#add) or [modifying](../operations/hosts.md#update) the host.

It is not possible to modify a public address after creating a host, but you can replace one of the existing hosts with a new host that has a public address.

When you delete a host with a public IP, its corresponding FQDN is withdrawn.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, be sure to [configure security groups](../operations/connect/index.md#configuring-security-groups) both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

{% endif %}
