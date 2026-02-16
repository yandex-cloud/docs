---
title: Справочник аудитных логов {{ mspqr-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий уровня сервисов и конфигурации {{ mspqr-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}


В {{ at-name }} для {{ mspqr-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.spqr.<имя_события>
```

{% include [about-events-ref](../_includes/audit-trails/about-events-ref.md) %}

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [mspqr-events](../_includes/audit-trails/events/mspqr-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [mspqr-events-dp](../_includes/audit-trails/events/mspqr-events-dp.md) %}
