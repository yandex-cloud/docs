---
title: Network and database clusters in {{ mch-name }}
description: When creating a {{ mch-name }} cluster, you can set a network for the cluster itself and subnets for each cluster host. You can also request public access to connect to the cluster from outside {{ yandex-cloud }}.
---

# Network and database clusters in {{ mch-name }}


When creating a {{ CH }} cluster, you can:

* Specify a network for the cluster.

* Specify subnets for each host in the cluster.

* Request public access to connect to the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for hosts if the availability zone for each host contains only one subnet of the cluster network.


## Host name and FQDN {#hostname}

{{ mch-short-name }} generates a name for each cluster host when creating it. This name will be the host's fully qualified domain name (FQDN). You cannot change the host name and, consequently, FQDN.

For how to get a host FQDN, see [this guide](../operations/connect/fqdn.md).


To access a host within a single cloud network, use its FQDN. For more information, see [this {{ vpc-full-name }} guide](../../vpc/).

## Public access to a host {#public-access-to-a-host}

You can make any cluster host accessible from outside {{ yandex-cloud }} by requesting public access when creating the host.

You cannot request a public address after creating the host; however, you can replace one of the existing hosts with a new one that has a public address.

When deleting a publicly accessible host, the allocated IP address is revoked.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

For information on how to configure security groups, see [{#T}](../operations/connect/index.md#configuring-security-groups).

{% note tip %}

When connecting to a cluster from the same cloud network it resides in, configure security groups not just for the cluster but also for the host you are connecting from.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}


## Use cases {#examples}

* [{#T}](../tutorials/dns-peering.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
