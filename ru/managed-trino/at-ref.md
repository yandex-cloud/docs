---
title: Справочник аудитных логов {{ mtr-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ mtr-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ mtr-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.trino.<имя_события>
```

{% include [mtr-events](../_includes/audit-trails/events/managed-trino-events.md) %}