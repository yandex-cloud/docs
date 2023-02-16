---
title: "Quotas and limits in {{ mos-name }}"
description: "{{ mos-name }} has limits and quotas for the number of clusters, total number of processor cores for all hosts, total amount of RAM for all hosts, and total storage for all clusters per cloud. For more information about the service restrictions, read this article."
---

{% if audience != "internal" %}

# Quotas and limits in {{ mos-name }}

{{ mos-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [limits.md](../../_includes/mdb/mos/limits.md) %}

{% else %}

# Technical restrictions of {{ mos-name }}

| Type of limit | Value |
|----------------------------------------------------------|-----------------------------------|
| Lowest host class | s2.micro (1 vCPU, 4 GB RAM) |
| Highest host class | m3-c80-m640 (80 vCPU, 640 GB RAM) |
| Maximum number of hosts per {{ OS }} cluster | 7 |
| Maximum storage capacity for a {{ OS }} cluster | 4096 GB |

{% endif %}
