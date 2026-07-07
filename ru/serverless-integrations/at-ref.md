---
title: Справочник аудитных логов {{ sw-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ sw-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ sw-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.serverless.workflows.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [workflows-events](../_includes/audit-trails/events/workflows-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [workflows-events-dp](../_includes/audit-trails/events/workflows-events-dp.md) %}
