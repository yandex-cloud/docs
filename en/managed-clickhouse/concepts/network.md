# DB network and clusters

{% if audience != "internal" %}

When creating a cluster, you can:

* Set the network for the cluster itself.

* Set the subnets for each host in the cluster.

* Request a public IP address to access the cluster from outside the Cloud.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.

{% else %}

All the clusters are created within the `_PGAASINTERNALNETS_` network macro. To connect to the created database, request access in [Puncher](https://puncher.yandex-team.ru/). To connect to {{ CH }}, specify ports 8443 (HTTPS) and 9440 (native TLS-enabled protocol) in your request.

{% endif %}

## Hostname and FQDN {#hostname}

{{ mch-short-name }} generates a name for each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network. Read more in the [documentation for {{ vpc-full-name }}](../../vpc/).

## Public access to a host

Any cluster host can be accessible from outside Yandex.Cloud if you requested public access when creating the host. To connect to such a host, use its FQDN.

It is not possible to request a public address after creating a host, but you can replace one of the existing hosts with a new host that has a public address.

When deleting a host with a public FQDN, the assigned IP address is revoked.

{% endif %}

