---
title: "Quotas and limits in {{ mmg-name }}"
description: "{{ mmg-name }} has limits and quotas for the number of clusters, total number of processor cores for all database hosts, total amount of RAM for all database hosts, and total storage for all clusters per cloud. For more information about the service restrictions, read this article."

editable: false
---

{% if audience != "internal" %}

# Quotas and limits in {{ mmg-name }}

{{ mmg-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mmg-limits.md](../../_includes/mdb/mmg-limits.md) %}

{% else %}

# Technical restrictions of {{ mmg-name }}

| Type of limit | Minimum value | Maximum value |
|------------------------------------------------------------------|--------------------------------------------------------------------------------|--------------------------------------------------|
| Host class | s2.nano (1 Intel Broadwell vCPU, 4 GB RAM) | m3-c80-m640 (80 vCPU Intel Ice Lake, 640 GB RAM) |
| Number of shards per cluster | 1 | 10 |
| Number of hosts in a shard when using network storage | 1 | 7 |
| Number of hosts in a shard when using local storage | 3 | 7 |
| Number of hosts per cluster | 1 host (clusters are unsharded at [creation](../operations/cluster-create.md)) | 70 (10 shards × 7 hosts) |
| Amount of data on the host when using network storage | 10 GB | 300 GB |
| Amount of data on the host when using a local storage | 100 GB | 300 GB |

{% endif %}
