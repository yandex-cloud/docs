---
title: Справочник аудитных логов {{ mgl-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ mgl-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ mgl-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.gitlab.<имя_события>
```

{% include [mgl-events](../_includes/audit-trails/events/mgl-events.md) %}
