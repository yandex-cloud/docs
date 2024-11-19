---
title: Справочник аудитных логов {{ managed-k8s-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ managed-k8s-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ managed-k8s-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.k8s.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [managed-k8s-events](../_includes/audit-trails/events/managed-k8s-events.md) %}

