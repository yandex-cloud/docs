---
title: Справочник аудитных логов {{ connection-manager-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ connection-manager-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ connection-manager-full-name }}


В {{ at-name }} для {{ connection-manager-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.connectionmanager.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [connectionmanager-events](../_includes/audit-trails/events/connectionmanager-events.md) %}
