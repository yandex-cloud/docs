---
title: Quotas and Limits in Managed Service for SQL Server
description: 'Managed Service for SQL Server has limits and quotas for the number of clusters, the total number of processor cores for all database hosts, the total amount of virtual memory for all database hosts, and the total amount of storage for all clusters in one cloud. You will learn more about the limitations of the service in this article. '

editable: false
---

{% if audience != "internal" %}

# Quotas and limits in {{ mms-name }}

{{ mms-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mms-limits.md](../../_includes/mdb/mms-limits.md) %}

For more information about the editions available, {{ MS }} see [{#T}](../concepts/index.md).

{% else %}

# Technical restrictions {{ mms-name }}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | s2.nano (1 vCPU, 4 GB RAM) |
| Highest host class | s3.6xlarge (64 vCPU, 256 GB RAM) |
| Maximum number of hosts per cluster {{ MS }} | 7 |
| Maximum storage capacity for a cluster {{ MS }} | 4096 GB |

{% endif %}

