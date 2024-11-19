---
title: Справочник аудитных логов {{ data-transfer-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ data-transfer-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ data-transfer-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.datatransfer.<имя_события>
```

{% include [datatransfer-events](../_includes/audit-trails/events/datatransfer-events.md) %}
