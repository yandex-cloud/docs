---
title: Quotas and Limits in Managed Service for MongoDB
description: 'Managed Service for MongoDB has limits and quotas for the number of clusters, the total number of processor cores for all database hosts, the total amount of virtual memory for all database hosts, and the total amount of storage for all clusters in one cloud. You will learn more about the limitations of the service in this article.'

editable: false
---

{% if audience != "internal" %}

# Quotas and limits

{{ mmg-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mmg-limits.md](../../_includes/mdb/mmg-limits.md) %}

{% else %}

# Technical restrictions of {{ mmg-name }}

| Type of limit | Minimum value | Maximum value |
| ---- | ---- | ---- |
| Host class | s2.nano (1 Intel Broadwell vCPU, 4 GB RAM) | s3.6xlarge (64 Intel Cascade Lake vCPUs, 257 GB RAM) |
| Number of shards in a cluster | 1 | 10 |
| Number of hosts in a shard when using network storage | 1 | 7 |
| Number of hosts in a shard when using local storage | 3 | 7 |
| Number of hosts per cluster | 1 host (clusters are unsharded at [creation](../operations/cluster-create.md)) | 70 (10 shards × 7 hosts) |
| Amount of data on the host when using network storage | 10 GB | 300 GB |
| Amount of data on the host when using local storage | 100 GB | 300 GB |

{% endif %}
