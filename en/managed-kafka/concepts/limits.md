---
title: "Quotas and limits in {{ mkf-name }}®"
description: "{{ mkf-name }}® has limits and quotas on the number of clusters, total number of processor cores for all broker hosts, total amount of RAM for all broker hosts, and total storage for all clusters per cloud. For more information about the service restrictions, read this article."

editable: false
---

{% if audience != "internal" %}

# Quotas and limits in {{ mkf-name }}

{{ mkf-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mkf-limits.md](../../_includes/mdb/mkf-limits.md) %}

{% else %}

# Technical restrictions of {{ mkf-name }}

| Type of limit | Value |
|----------------------------------------------------------|-----------------------------------|
| Lowest host class | s2.micro (1 vCPU, 4 GB RAM) |
| Highest host class | m3-c80-m640 (80 vCPU, 640 GB RAM) |
| Maximum number of hosts per {{ KF }} cluster | 7 |
| Maximum storage capacity for a {{ KF }} cluster | 4096 GB |

{% endif %}
