---
editable: false
---
{% if audience != "internal" %}

# Quotas and limits

{{ mpg-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mpg-limits.md](../../_includes/mdb/mpg-limits.md) %}

{% else %}

# Technical restrictions {{ mpg-name }}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | s2.nano (1 vCPU, 4 GB RAM) |
| Highest host class | s3.6xlarge (64 vCPU, 256 GB RAM) |
| Maximum number of hosts per cluster {{ PG }} | 7 |
| Maximum storage capacity for a cluster {{ PG }} | 4096 GB |

{% endif %}

