---
title: Справочник аудитных логов {{ mkf-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ mkf-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ mkf-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.kafka.<имя_события>
```

{% include [managed-kafka-events](../_includes/audit-trails/events/managed-kafka-events.md) %}