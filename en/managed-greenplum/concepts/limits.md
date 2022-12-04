---
editable: false
---

{% if audience != "internal" %}

# Quotas and limits in {{ mgp-name }}

{{ mgp-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [mgp-limits](../../_includes/mdb/mgp/limits.md) %}

{% else %}

# Technical restrictions of {{ mgp-name }}

| Type of limit | Value |
|-------------------------------------------|----------------------|
| Minimum number of cores | 4 |
| Minimum RAM amount | 16 GB |
| Maximum number of cores | 64 (s3.6xlarge) |
| Maximum RAM amount | 384 ГБ (m3.11xlarge) |
| Maximum number of master hosts | 2 |
| Maximum number of segment hosts | 32 |
| Maximum storage size per host | 4096 GB |

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
