---
title: "Network and clusters in {{ mpg-name }}"
description: "When creating a {{ PG }} cluster, you can set a network for the cluster and subnets for each of the cluster hosts. You can also request a public IP address to enable cluster access from outside {{ yandex-cloud }}."
---

# Network and clusters in {{ mpg-name }}


When creating a {{ PG }} cluster, you can:

* Specify a network for the entire cluster.

* Specify subnets for each host in the cluster.

* Request a public IP address to access the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.


## Hostname and FQDN {#hostname}

{{ mpg-short-name }} generates a name for each cluster host when it is being created. This name will be the host's fully qualified domain name (FQDN). The host name and, consequently, the FQDN cannot be changed.


You can use the FQDN to access the host within a single cloud network. For more information, see the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating or editing a host. To connect to such kind of a host, use its FQDN.

When deleting a host with a public FQDN, the assigned IP address is revoked.

## Security groups {#security-groups}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, make sure to [configure](../operations/connect.md#configuring-security-groups) security groups both for the cluster and for the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

