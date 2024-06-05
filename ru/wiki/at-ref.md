# Справочник аудитных логов {{ wiki-full-name }}

В {{ at-name }} для {{ wiki-full-name }} поддерживается отслеживание [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.wiki.<имя_события>
```

## Справочник событий уровня сервисов {#data-plane-events}

{% include [wiki-events-dp](../_includes/audit-trails/events/wiki-events-dp.md) %}
