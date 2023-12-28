---
title: "Network and DB clusters in {{ mch-name }}"
description: "When creating a cluster in {{ mch-name }}, you can set a network for the cluster and subnets for each cluster host. You can also request public access to connect to the cluster from outside {{ yandex-cloud }}."
---

# Network and DB clusters in {{ mch-name }}


When creating a {{ CH }} cluster, you can:

* Specify a network for the entire cluster.

* Specify subnets for each host in the cluster.

* Request public access to connect to the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts if the availability zone selected for each host contains exactly one subnet of the cluster network.


## Host name and FQDN {#hostname}

{{ mch-short-name }} generates the name of each cluster host when creating it. This name will be the host's fully qualified domain name (FQDN). The host name and, consequently, FQDN cannot be changed.

To learn how to get a host FQDN, see [this guide](../operations/connect.md#fqdn).


To access a host within a single cloud network, use its FQDN. For more information, see the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating the host.

You cannot request a public address after creating a host; however, you can replace one of the existing hosts with a new one that has a public address.

When deleting a publicly accessible host, the assigned IP address is revoked.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, make sure to [configure](../operations/connect.md#configuring-security-groups) security groups both for the cluster and for the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
