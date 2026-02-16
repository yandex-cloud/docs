---
title: Справочник аудитных логов {{ message-queue-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ message-queue-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ message-queue-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.ymq.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [ymq-events](../_includes/audit-trails/events/ymq-events.md) %}