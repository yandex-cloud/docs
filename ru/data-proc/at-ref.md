---
title: Справочник аудитных логов {{ dataproc-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ dataproc-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ dataproc-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.dataproc.<имя_события>
```

{% include [dataproc-events](../_includes/audit-trails/events/dataproc-events.md) %}
