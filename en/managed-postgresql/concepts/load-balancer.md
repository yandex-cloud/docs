---
title: Load balancer for {{ mpg-name }} hosts
description: You can create an L4 load balancer when creating or modifying a {{ PG }} cluster to adjust the DB load across hosts based on the host's availability, its role in the cluster, or its lag time behind the master.
---

# Load balancer for hosts

{{ mpg-name }} allows you to use an internal network balancer to distribute the load among hosts. This load balancer operates on layer 4 of the OSI network model but uses layer 3 technologies to speed up packet processing.

{% note info %}

This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. Contact support for access.

{% endnote %}

{% include [load-balancer](../../_includes/mdb/load-balancer.md) %}

{% note info %}

When using a load balancer, client connections remain controlled by the [Odyssey connection manager](pooling.md).

{% endnote %}
