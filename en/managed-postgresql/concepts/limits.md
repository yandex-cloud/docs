---
title: Quotas and Limits in Managed Service for PostgreSQL
description: 'Managed Service for PostgreSQL has limits and quotas for the number of clusters, the total number of processor cores for all database hosts, the total amount of virtual memory for all database hosts, the total amount of storage for all clusters in one cloud. You will learn more about the limitations of the service in this article. '

editable: false
---

{% if audience != "internal" %}

# Quotas and limits in {{ mpg-name }}

{{ mpg-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mpg-limits.md](../../_includes/mdb/mpg-limits.md) %}

{% else %}

# Technical restrictions of {{ mpg-name }}

| Type of limit | Value |
|----------------------------------------------------------|-----------------------------------|
| Lowest host class | s2.nano (1 vCPU, 4 GB of RAM) |
| Highest host class | m3-c80-m640 (80 vCPU, 640 GB of RAM) |
| Maximum number of hosts per {{ PG }} cluster | 7 |
| Maximum storage capacity for a {{ PG }} cluster | 4096 GB |

{% endif %}
