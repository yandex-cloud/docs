# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ iam-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.iam.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [iam-events](../_includes/audit-trails/events/iam-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [iam-events-dp](../_includes/audit-trails/events/iam-events-dp.md) %}
