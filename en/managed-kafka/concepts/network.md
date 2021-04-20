# Network in {{ mkf-name }}

{% if audience != "internal" %}

When creating a cluster, you can:

* Set the network for cluster hosts.
* Specify the availability zones where the cluster hosts should reside.
* Set subnets in all availability zones.
* Turn on public access to the cluster from outside {{ yandex-cloud }}.

If hosts are present in the {{ ZK }} cluster, each of the three {{ ZK }} hosts uses its dedicated availability zone and the subnet selected in it. For more information, see [{#T}](../concepts/index.md).

{% else %}

All the clusters are created within the `_PGAASINTERNALNETS_` network macro. To connect to the created cluster, request access in [Puncher](https://puncher.yandex-team.ru/). To connect to {{ KF }}, specify port 9091 (SASL_TLS) in your request.

{% endif %}

## Hostname and FQDN {#hostname}

{{ mkf-short-name }} generates the name of each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network. Read more in the [{{ vpc-full-name }} documentation](../../vpc/).

{% endif %}

## Public access to the cluster {public-access-to-a-cluster}

All [broker hosts](brokers.md) in the cluster are available from outside {{ yandex-cloud }} if you request public access when [creating a cluster](../operations/cluster-create.md). To connect to such a cluster, use the FQDN of one or more of the cluster's broker hosts.

You can't request public access after creating a cluster.

When you delete a cluster with public access enabled, all public IP addresses assigned to this cluster are revoked.
