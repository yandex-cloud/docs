---
title: Справочник аудитных логов {{ sf-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ sf-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ sf-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.serverless.<имя_события>
```

{% include [functions-events](../_includes/audit-trails/events/functions-events.md) %}