---
title: Справочник аудитных логов {{ backup-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ backup-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ backup-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.backup.<имя_события>
```

{% include [backup-events](../_includes/audit-trails/events/backup-events.md) %}