---
title: Справочник аудитных логов {{ load-testing-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ load-testing-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ load-testing-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.loadtesting.<имя_события>
```

{% include [load-testing-events](../_includes/audit-trails/events/load-testing-events.md) %}