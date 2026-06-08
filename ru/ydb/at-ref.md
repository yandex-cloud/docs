---
title: Справочник аудитных логов {{ ydb-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ ydb-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ ydb-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.ydb.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [ydb-events](../_includes/audit-trails/events/ydb-events.md) %}