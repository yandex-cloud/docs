# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ sws-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.smartwebsecurity.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [sws-events](../_includes/audit-trails/events/sws-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [sws-events-dp](../_includes/audit-trails/events/sws-events-dp.md) %}
