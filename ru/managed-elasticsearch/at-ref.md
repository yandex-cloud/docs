---
title: Справочник аудитных логов {{ mes-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ mes-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ mes-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.elasticsearch.<имя_события>
```

{% include [mes-events](../_includes/audit-trails/events/mes-events.md) %}
