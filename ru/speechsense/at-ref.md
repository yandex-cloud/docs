# Справочник аудитных логов {{ speechsense-full-name }}

В {{ at-name }} для {{ speechsense-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.speechsense.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [speechsense-events](../_includes/audit-trails/events/speechsense-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [speechsense-events-dp](../_includes/audit-trails/events/speechsense-events-dp.md) %}