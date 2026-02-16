---
title: Справочник аудитных логов {{ vision-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ vision-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня сервисов (Data Plane) для {{ vision-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.ai.ocr.<имя_события>
```

{% include [vision-events-dp](../_includes/audit-trails/events/vision-events-dp.md) %}