---
title: Справочник аудитных логов {{ certificate-manager-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ certificate-manager-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ certificate-manager-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.certificatemanager.<имя_события>
```

{% include [cm-events](../_includes/audit-trails/events/cm-events.md) %}
