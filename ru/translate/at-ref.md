---
title: Справочник аудитных логов {{ translate-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ translate-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня сервисов (Data Plane) для {{ translate-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.ai.translate.<имя_события>
```

{% include [translate-events-dp](../_includes/audit-trails/events/translate-events-dp.md) %}