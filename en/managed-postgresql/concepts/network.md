# DB network and clusters

{% if audience != "internal" %}

 When creating a cluster, you can:

* Set the network for the cluster itself.

* Set the subnets for each host in the cluster.

* Request a public IP address to access the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

{% else %}

All the clusters are established within our network which is already [accessible](../../mdb/access.md#network-access) from most networks and by most employees. If you have no access, request access in [Puncher](https://puncher.yandex-team.ru/) to a macro called `_PGAASINTERNALNETS_`. To connect to {{ PG }}, specify port 3306 in your request.

{% endif %}

## Hostname and FQDN {#hostname}

{{ mpg-short-name }} generates a name for each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network. Read more in the [{{ vpc-full-name }} documentation](../../vpc/).


## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating or editing the host. To connect to this kind of host, use its FQDN.

When deleting a host with a public FQDN, the assigned IP address is revoked.

{% endif %}

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, be sure to [configure](../operations/connect.md#configuring-security-groups) security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}
