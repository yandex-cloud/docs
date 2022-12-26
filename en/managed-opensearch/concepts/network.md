# Network in {{ mos-name }}

{% if audience != "internal" %}

When creating a cluster, you can:

* Set the network for the cluster itself.
* Set the subnets for each host in the cluster.
* Request a public IP address to access the cluster's host groups from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

{% else %}

{% include notitle [Internal access](../../_includes/mdb/internal-access.md) %}

{% endif %}

## Hostname and FQDN {#hostname}

{{ mos-short-name }} generates the name of each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network. Read more in the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating its host group. To connect to this kind of host, use its FQDN.

You can't request public access after creating a host group.

When deleting a host group with public FQDNs, the assigned IP addresses are revoked.

## Security groups {#security-groups}

Security groups follow the principle "All traffic that is not allowed is prohibited". To connect to a cluster, security groups must include rules allowing traffic from certain ports, IP addresses, or from other security groups.

For example, a host group of the `DASHBOARDS` type is assigned a public IP address. If there's no security group rule that allows connecting to it from the internet on port `{{ port-https }}`, you won't be able to connect to the web interface. You also won't be able to access an `OPENSEARCH` host group that has no security group rule that explicitly allows incoming traffic on port `{{ port-mos }}`.

{% note tip %}

If you connect to a cluster from within its cloud network, [configure](../operations/connect.md#security-groups) security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

{% endif %}
