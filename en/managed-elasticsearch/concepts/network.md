# Network in {{ mes-name }}

{% if audience != "internal" %}

When creating a cluster, you can:

* Set the network for the cluster itself.
* Set the subnets for each host in the cluster.
* Request a public IP address to access cluster hosts with the [_Data node_ role](./index.md) from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

{% else %}

All of the clusters are created inside our network, which is [accessible](../../mdb/access.md#network-access) from most networks and by most employees. If you don't have access, request access to the macro `_PGAASINTERNALNETS_` in [Puncher](https://puncher.yandex-team.ru/). To connect to {{ ES }}, specify port 9200 (Elasticsearch) and/or port 443 (Kibana) in your request.

{% endif %}

## Hostname and FQDN {#hostname}

{{ mes-short-name }} generates a name for each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network. Read more in the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating the host. To connect to this kind of host, use its FQDN.

You can't request public access after creating a host.

When deleting a host with a public FQDN, the assigned IP address is revoked.

{% endif %}

## Security groups {#security-groups}

Security groups follow the principle "All traffic that is not allowed is prohibited". To connect to a cluster, security groups must include rules allowing traffic from certain ports, IP addresses, or from other security groups.

Say, for example, that a host with the _Data node_ role is assigned a public IP address. If there's no security group rule that allows connecting to it from the internet on port `443`, you won't be able to connect to the Kibana web interface. You also won't be able to access a host that has no security group rule that explicitly allows incoming traffic on port `9200`.

{% note tip %}

If you connect to a cluster from within its cloud network, [configure](../operations/cluster-connect.md#configuring-security-groups) security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}
