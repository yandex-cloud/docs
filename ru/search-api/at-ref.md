---
title: Справочник аудитных логов {{ search-api-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ search-api-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ search-api-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.searchapi.<имя_события>
```

{% include [searchapi-events](../_includes/audit-trails/events/searchapi-events.md) %}