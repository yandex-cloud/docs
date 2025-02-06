---
title: Справочник аудитных логов {{ billing-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ billing-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ billing-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.billing.<имя_события>
```

{% include [billing-events](../_includes/audit-trails/events/billing-events.md) %}