---
title: Справочник аудитных логов {{ alb-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ alb-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ alb-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.apploadbalancer.<имя_события>
```

{% include [alb-events](../_includes/audit-trails/events/alb-events.md) %}
