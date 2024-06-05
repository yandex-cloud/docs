# Справочник аудитных логов {{ websql-full-name }}

В {{ at-name }} для {{ websql-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.websql.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [websql-events](../_includes/audit-trails/events/websql-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [websql-events-dp](../_includes/audit-trails/events/websql-events-dp.md) %}