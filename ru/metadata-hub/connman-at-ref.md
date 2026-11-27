---
title: Справочник аудитных логов {{ connection-manager-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ connection-manager-name }}, отслеживаемых в {{ at-name }}.
alternate:
  - href: ru/metadata-hub/connman-at-ref.md
    type: text/markdown
    title: Markdown version
---

# Справочник аудитных логов {{ connection-manager-full-name }}


В {{ at-name }} для {{ connection-manager-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.connectionmanager.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [connectionmanager-events](../_includes/audit-trails/events/connectionmanager-events.md) %}
