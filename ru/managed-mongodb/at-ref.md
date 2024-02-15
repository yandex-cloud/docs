# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ mmg-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.mongodb.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [mongodb-events](../_includes/audit-trails/events/mongodb-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include notitle [preview](../_includes/note-preview-by-request.md) %}

{% include [mmg-events-dp](../_includes/audit-trails/events/mmg-events-dp.md) %}