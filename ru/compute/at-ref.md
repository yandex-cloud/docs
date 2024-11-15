---
title: Справочник аудитных логов {{ compute-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий уровня сервисов и конфигурации {{ compute-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}


В {{ at-name }} для {{ compute-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.compute.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [compute-events](../_includes/audit-trails/events/compute-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [compute-events-dp](../_includes/audit-trails/events/compute-events-dp.md) %}
