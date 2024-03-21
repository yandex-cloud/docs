---
title: "Networking in {{ mpg-name }}"
description: "When creating a {{ PG }} cluster, you can set a network for the cluster and subnets for each cluster host. You can also request public access to connect to the cluster from outside {{ yandex-cloud }}."
---

# Networking in {{ mpg-name }}


When creating a {{ PG }} cluster, you can:

* Specify a network for the entire cluster.

* Specify subnets for each host in the cluster.

* Request public access to connect to the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts if the availability zone selected for each host contains exactly one subnet of the cluster network.


## Host name and FQDN {#hostname}

{{ mpg-short-name }} generates a name for each cluster host when it is created. This name will be the host's fully qualified domain name (FQDN). The host name and, consequently, FQDN cannot be changed.

{% include [see-fqdn](../../_includes/mdb/mpg/fqdn-host.md) %}


To access a host within a single cloud network, use its FQDN. For more information, see the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating or editing a host.

When deleting a publicly accessible host, the assigned IP address is revoked.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

{% note tip %}

When connecting to a cluster from within its cloud network, make sure to [configure](../operations/connect.md#configuring-security-groups) security groups both for the cluster and for the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

