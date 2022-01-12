---
sourcePath: overlay/troubleshooting/_includes/system_views/query_metrics.md
---

{% include [header.md](query_metrics_header.md) %}

Примеры:

{% if audience != "external" %}

{% list tabs %}

- YQL

{% include [example_yql](query_metrics_example_yql.md) %}

- Clickhouse over YDB

{% include [example_ch](query_metrics_example_ch.md) %}

{% endlist %}

{% endif %}