---
title: Справочник аудитных логов {{ org-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ org-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ org-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.organizationmanager.<имя_события>
```

{% include [org-events](../_includes/audit-trails/events/org-events.md) %}
