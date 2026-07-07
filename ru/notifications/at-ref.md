---
title: Справочник аудитных логов {{ cns-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ cns-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ cns-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.notifications.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [notifications-events](../_includes/audit-trails/events/notifications-events.md) %}
