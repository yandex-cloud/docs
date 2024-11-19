---
title: Справочник аудитных логов {{ iot-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ iot-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ iot-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.iot.<имя_события>
```

{% include [iot-events](../_includes/audit-trails/events/iot-events.md) %}
