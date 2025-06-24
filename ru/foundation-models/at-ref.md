---
title: Справочник аудитных логов {{ foundation-models-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ foundation-models-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня сервисов (Data Plane) для {{ foundation-models-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.ai.foundationmodel.<имя_события>
```

{% include [foundation-models-dp](../_includes/audit-trails/events/foundation-models-dp.md) %}