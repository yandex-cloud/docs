---
editable: false
---
{% if audience != "internal" %}

# Quotas and limits

{{ mkf-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mkf-limits.md](../../_includes/mdb/mkf-limits.md) %}

{% else %}

# Technical restrictions {{ mkf-name }}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | s2.micro (1 vCPU, 4 GB RAM) |
| Highest host class | s3.6xlarge (64 vCPU, 256 GB RAM) |
| Maximum number of hosts per cluster {{ KF }} | 7 |
| Maximum storage capacity for a cluster {{ KF }} | 4096 GB |

{% endif %}

