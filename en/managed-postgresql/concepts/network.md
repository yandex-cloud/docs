---
title: Networking in {{ mpg-name }}
description: When creating a {{ PG }} cluster, you can set a network for the cluster itself and subnets for each cluster host. You can also request public access for connection to the cluster from outside {{ yandex-cloud }}.
---

# Networking in {{ mpg-name }}


When creating a {{ PG }} cluster, you can:

* Specify a network for the cluster.

* Specify subnets for each host in the cluster.

* Request public access to connect to the cluster from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for hosts if the availability zone for each host contains only one subnet of the cluster network.


## Host name and FQDN {#hostname}

{{ mpg-short-name }} generates a name for each cluster host when it is created. This name will be the host's fully qualified domain name (FQDN). You cannot change the host name and, consequently, FQDN.

{% include [see-fqdn](../../_includes/mdb/mpg/fqdn-host.md) %}


To access a host within a single cloud network, use its FQDN. For more information, see [this {{ vpc-full-name }} guide](../../vpc/).

## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating or editing a host.

When deleting a publicly accessible host, the allocated IP address is revoked.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

For information on how to configure security groups, see [{#T}](../operations/connect/index.md#configuring-security-groups).

{% note tip %}

When connecting to a cluster from the same cloud network it resides in, configure security groups not just for the cluster but also for the host you are connecting from.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}


## Use cases {#examples}

* [{#T}](../tutorials/cdc-data-transfer.md)
* [{#T}](../tutorials/cdc-debezium.md)
* [{#T}](../tutorials/outbound-replication.md)
