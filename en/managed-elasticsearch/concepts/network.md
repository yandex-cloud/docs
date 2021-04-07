# Network in {{ mes-name }}

{% if audience != "internal" %}

When creating a cluster, you can:

- Set the network for the cluster itself.
- Set the subnets for each host in the cluster.
- Request a public IP address to access cluster hosts with the [_Data node_ role](index.md) from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

{% else %}

All clusters are created inside our network, which is [already accessible](../../mdb/access.md#network-access) from most networks and most employees. If you don't have access, request access to the macro `_PGAASINTERNALNETS_` in [Puncher](https://puncher.yandex-team.ru/). To connect to {{ ES }}, specify port 9200 (Elasticsearch) and/or port 443 (Kibana) in your request.

{% endif %}

## Hostname and FQDN {#hostname}

{{ mes-short-name }} generates a name for each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network. Read more in the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating the host. To connect to this kind of host, use its FQDN.

It is not possible to request a public address after creating a host, but you can replace one of the existing hosts with a new host that has a public address.

When deleting a host with a public FQDN, the assigned IP address is revoked.

{% endif %}

