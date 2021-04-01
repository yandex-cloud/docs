---
editable: false
---
{% if audience != "internal" %}

# Quotas and limits

{{ mmg-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mmg-limits.md](../../_includes/mdb/mmg-limits.md) %}

{% else %}

# Technical restrictions of {{ mmg-name }}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | s2.nano (1 vCPU, 4 GB RAM) |
| Highest host class | s3.6xlarge (64 vCPU, 256 GB RAM) |
| Maximum number of hosts per {{ MG }} shard | 7 |
| Maximum number of {{ MG }} shards | 10 |
| Maximum storage capacity for a {{ MG }} cluster | 512 GB |

{% endif %}

