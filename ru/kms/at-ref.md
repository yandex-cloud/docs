# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ kms-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.kms.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [kms-events](../_includes/audit-trails/events/kms-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [kms-events-dp](../_includes/audit-trails/events/kms-events-dp.md) %}