---
title: Quotas and Limits in Managed Service for Apache Kafka®
description: 'Managed Service for Apache Kafka® has limits and quotas for the number of clusters, the total number of processor cores for all host brokers, the total amount of virtual memory for all host brokers, the total amount of storage for all clusters in one cloud. You will learn more about the limitations of the service in this article.'

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
