---
title: "Quotas and limits in {{ mms-name }}"
description: "{{ mms-name }} has limits and quotas for the number of clusters, total number of processor cores for all database hosts, total amount of virtual memory for all database hosts, and total storage for all clusters per cloud. For more information about the service restrictions, read this article."

editable: false
---

{% if audience != "internal" %}

# Quotas and limits in {{ mms-name }}

{{ mms-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mms-limits.md](../../_includes/mdb/mms-limits.md) %}

For more information about the editions available, {{ MS }} see [{#T}](../concepts/index.md).

{% else %}

# Technical restrictions of {{ mms-name }}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | s2.small (4 vCPU, 16 GB RAM) |
| Highest host class | s3-c96-m576 (96 vCPU, 576 GB RAM) |
| Maximum number of hosts per {{ MS }} cluster | 7 |
| Maximum storage capacity for a {{ MS }} cluster | 4096 GB |

{% endif %}
