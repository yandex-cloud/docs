# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ mmy-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.mysql.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [mysql-events](../_includes/audit-trails/events/mysql-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [mmy-events-dp](../_includes/audit-trails/events/mmy-events-dp.md) %}