---
title: Справочник аудитных логов {{ mgp-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ mgp-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ mgp-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.greenplum.<имя_события>
```

{% include [mgp-events](../_includes/audit-trails/events/managed-greenplum-events.md) %}