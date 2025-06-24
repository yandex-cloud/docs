---
title: Справочник аудитных логов {{ speechkit-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ speechkit-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня сервисов (Data Plane) для {{ speechkit-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.ai.speechkit.<имя_события>
```

{% include [speechkit-events-dp](../_includes/audit-trails/events/speechkit-events-dp.md) %}