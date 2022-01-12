---
sourcePath: overlay/troubleshooting/system_views.md
---

{% include [intro.md](_includes/system_views/intro.md) %}

{% if audience == "external" %}

В настоящее время доступ к системным таблицам возможен через веб-интерфейс.

{% else %}

Доступ к системным таблицам возможен через [ClickHouse over YDB](../getting_started/start_chydb.md) и через [аналитические запросы](../concepts/scan_query.md).

Для обращения к системным таблицам через ClickHouse over YDB следует использовать функцию `ydbTable`, например: `ydbTable('cluster', '/cluster/path/to/database', '.sys/system_view_name')`.

{% note info %}

Поля с типами `Timestamp` и `Interval` при запросах через СlickHouse over YDB будут представлены типами `Uint64` и `Int64` (микросекунды) соответственно.

{% endnote %}

{% endif %}

{% include [partitions.md](_includes/system_views/partitions.md) %}

{% include [tops.md](_includes/system_views/tops.md) %}

{% include [query_metrics.md](_includes/system_views/query_metrics.md) %}

{% include [notes.md](_includes/system_views/notes.md) %}
