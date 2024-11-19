---
title: Справочник аудитных логов {{ ml-platform-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ ml-platform-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ ml-platform-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.datasphere.<имя_события>
```

{% include [ds-events](../_includes/audit-trails/events/ds-events.md) %}