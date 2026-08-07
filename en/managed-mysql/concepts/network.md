---
title: Networking in {{ mmy-name }}
description: When creating a {{ MY }} cluster, you can set a network for the cluster itself and subnets for each cluster host. You can also request public access for connection to the cluster from outside {{ yandex-cloud }}.
---

# Network and clusters in {{ mmy-name }}


When creating a {{ MY }} cluster, you can:

* Specify a network for the cluster.
* Specify subnets for each host in the cluster.
* Request public access to connect to the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for hosts if the availability zone for each host contains only one subnet of the cluster network.


## Host name and FQDN {#hostname}

{{ mmy-short-name }} generates a name for each cluster host when creating it. This name will be the host's fully qualified domain name (FQDN). You cannot change the host name and, consequently, FQDN.

{% include [see-fqdn](../../_includes/mdb/mmy/fqdn-host.md) %}


You can use the FQDN to access the host within a single cloud network. For more information, see [this {{ vpc-full-name }} guide](../../vpc/).

## Public access to a host {#public-access-to-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating or editing a host. To connect to such a host, use its FQDN.

When deleting a host with a public FQDN, the assigned IP address is revoked.


## Connecting to cluster hosts {#cluster-connect}


You can [connect to {{ mmy-name }} cluster hosts](../operations/connect/index.md):

* Via the internet, if you [configured](../operations/hosts.md#update) public access for the host. You can connect over the internet in the following ways:

    * Use an SSL connection.
    * Use IAM authentication.

* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../vpc/concepts/network.md). For hosts without public access, SSL is not required to connect to them from these virtual machines.


The maximum number of connections is defined by the [max_connections](./settings-list.md#setting-max-connections) setting, which [depends on the host class](./settings-list.md#settings-instance-dependent).

In addition to host names, to connect to a cluster, you can use [special FQDNs](../operations/connect/fqdn.md#special-fqdns) that point to the current master host and the replica that is least lagging from it.


## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

For information on how to configure security groups, see [{#T}](../operations/connect/index.md#configure-security-groups).

{% note tip %}

When connecting to a cluster from the same cloud network it resides in, configure security groups not just for the cluster but also for the host you are connecting from.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}


## Use cases {#examples}

* [{#T}](../tutorials/data-migration/index.md)
* [{#T}](../tutorials/sqoop.md)
* [{#T}](../tutorials/sync-mysql.md)
* [{#T}](../tutorials/bitrix-shop/index.md)
* [{#T}](../tutorials/bitrix-website/index.md)
* [{#T}](../tutorials/opencart/index.md)
