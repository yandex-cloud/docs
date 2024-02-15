# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ mch-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.clickhouse.<имя_события>
```

{% include [mch-events](../_includes/audit-trails/events/mch-events.md) %}

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}