---
title: Networking in {{ mmy-name }}
description: When creating a {{ MY }} cluster, you can set a network for the cluster itself and subnets for each cluster host. You can also request public access to connect to the cluster from outside {{ yandex-cloud }}.
---

# Network and clusters in {{ mmy-name }}


When creating a {{ MY }} cluster, you can:

* Specify a network for the entire cluster.
* Specify subnets for each host in the cluster.
* Request public access to connect to the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts if the availability zone selected for each host contains exactly one subnet of the cluster network.


## Host name and FQDN {#hostname}

{{ mmy-short-name }} generates the name of each cluster host when creating it. This name will be the host's fully qualified domain name (FQDN). The host name and, consequently, FQDN cannot be changed.

{% include [see-fqdn](../../_includes/mdb/mmy/fqdn-host.md) %}


You can use the FQDN to access the host within a single cloud network. For more information, see the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating or editing a host. To connect to such a host, use its FQDN.

When deleting a host with a public FQDN, the assigned IP address is revoked.


## Connecting to cluster hosts {#cluster-connect}

You can [connect to {{ mmy-short-name }} cluster hosts](../operations/connect.md):

{% include [cluster-connect-note](../../_includes/mdb/mmy/cluster-connect-note.md) %}

The maximum number of connections is defined by the [max_connections](./settings-list.md#setting-max-connections) setting, which [depends on the host class](./settings-list.md#settings-instance-dependent).

In addition to host names, to connect to a cluster, you can use [special FQDNs](../operations/connect.md#special-fqdns) that point to the current master host and the replica that is least lagging from it.


## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

For information on how to configure security groups, see [{#T}](../operations/connect.md#configure-security-groups).

{% note tip %}

When connecting to a cluster from the same cloud network, configure security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

