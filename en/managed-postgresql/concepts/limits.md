---
title: "Quotas and limits in {{ mpg-name }}"
description: "{{ mpg-name }} has limits and quotas for the number of clusters, total number of processor cores for all database hosts, total amount of RAM for all database hosts, and total storage for all clusters per cloud. For more information about the service restrictions, read this article."

editable: false
---

{% if audience != "internal" %}

# Quotas and limits in {{ mpg-name }}

{{ mpg-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [mpg-limits.md](../../_includes/mdb/mpg-limits.md) %}

{% else %}

# Technical restrictions of {{ mpg-name }}

| Type of limit | Value |
|----------------------------------------------------------|-----------------------------------|
| Lowest host class | s2.nano (1 vCPU, 4 GB of RAM) |
| Highest host class | m3-c80-m640 (80 vCPU, 640 GB RAM) |
| Maximum number of hosts per {{ PG }} cluster | 7 |
| Maximum storage capacity for a {{ PG }} cluster | 4096 GB |

{% endif %}
