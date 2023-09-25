# {{ mrd-short-name }} network and DB clusters


When creating a cluster, you can:

* Specify a network for the entire cluster.
* Specify subnets for each host in the cluster.
* Enable TLS support to connect to the cluster from outside {{ yandex-cloud }}.


## Host name and FQDN {#hostname}

{{ mrd-short-name }} generates a name for each cluster host when it is being created. This name will be the host's fully qualified domain name (FQDN). The host name and, consequently, the FQDN cannot be changed.


You can use the FQDN to access the host within a single cloud network.

## Public access to {#public-access-to-host} cluster hosts

If you create a {{ mrd-short-name }} cluster with TLS support, you can connect to it both from a {{ yandex-cloud }} VM and from the internet.

If you created a cluster without TLS support, you can only connect to it from a {{ yandex-cloud }} VM on the same cloud network. You cannot enable public access to a host in this type of cluster.

Any host in a cluster with TLS support enabled can be accessible from outside {{ yandex-cloud }} if you requested public access when [creating](../operations/hosts.md#add) or [modifying](../operations/hosts.md#update) the host.

You cannot update a public address after creating a host; however, you can replace one of the existing hosts with a new one that has a public address.

When deleting a publicly accessible host, the assigned IP address is revoked.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, make sure to [configure security groups](../operations/connect/index.md#configuring-security-groups) both for the cluster and for the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

