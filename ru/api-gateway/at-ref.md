---
title: Справочник аудитных логов {{ api-gw-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ api-gw-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ api-gw-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.serverless.apigateway.<имя_события>
```

{% include [api-gw-events](../_includes/audit-trails/events/api-gw-events.md) %}