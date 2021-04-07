{% if audience != "internal" %}

# Quotas and limits

{{ mes-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mes-limits.md](../../_includes/mdb/mes-limits.md) %}

{% else %}

# Technical restrictions of {{ mes-name }}

| Type of limit | Value |
| ----- | ----- |
| Lowest host class | s2.micro (1 vCPU, 4 GB RAM) |
| Highest host class | s3.6xlarge (64 vCPU, 256 GB RAM) |
| Maximum number of hosts per {{ ES }} cluster | 7 |
| Maximum storage capacity for a {{ ES }} cluster | 4096 GB |

{% endif %}

