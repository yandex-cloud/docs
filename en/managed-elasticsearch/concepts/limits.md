---
title: Quotas and Limits in Managed Service for Elasticsearch
description: 'Managed Service for Elasticsearch has limits and quotas for the number of clusters, the total number of processor cores for all hosts, the total amount of virtual memory for all hosts, the total amount of storage for all clusters in one cloud. You will learn more about the limitations of the service in this article.'
---

{% if audience != "internal" %}

# Quotas and limits in {{ mes-name }}

{{ mes-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mes-limits.md](../../_includes/mdb/mes-limits.md) %}

{% else %}

# Technical restrictions of {{ mes-name }}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | s2.micro (1 vCPU, 4 GB RAM) |
| Highest host class | s3.6xlarge (64 vCPU, 256 GB RAM) |
| Maximum number of hosts per {{ ES }} cluster | 7 |
| Maximum storage capacity for a {{ ES }} cluster | 4096 GB |

{% endif %}

