---
title: Networking in {{ mmg-full-name }}
description: In this tutorial, you will learn about the basic network interface settings for a {{ SD }} cluster.
---

# Networking in {{ mmg-name }}


When creating a cluster, you can:

* Specify a network for the entire cluster.

* Specify subnets for each host in the cluster.

* Request public access to connect to the cluster from outside {{ yandex-cloud }}.

You do not need to specify subnets for the hosts if the availability zone of each host contains only one subnet of the cluster network.


## Host name and FQDN {#hostname}

{{ mmg-short-name }} generates a name for each cluster host when creating it. This name will be the host's fully qualified domain name (FQDN). You cannot change the host name and, consequently, FQDN.

{% include [see-fdqn-host](../../_includes/mdb/mmg/fqdn-host.md) %}


You can use the FQDN to access the host within a single cloud network. For more information, see [this {{ vpc-full-name }} guide](../../vpc/).

## Public access to a host {#Public-access-to-host}

You can make any cluster host accessible from outside {{ yandex-cloud }} by requesting public access when creating the host. To connect to such a host, use its FQDN.

You cannot request a public address after creating the host; however, you can replace one of the existing hosts with a new one that has a public address.

When deleting a host with a public FQDN, the assigned IP address is revoked.

## Security groups {#security-groups}

{% include [sg-rules-limits](../../_includes/mdb/sg-rules-limits.md) %}

For information on how to configure security groups, see [{#T}](../operations/connect/index.md#configuring-security-groups).

{% note tip %}

When connecting to a cluster from the same cloud network it resides in, configure security groups not just for the cluster but also for the host you are connecting from.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}


## Use cases {#examples}

* [{#T}](../tutorials/migration-from-kafka.md)
