---
title: Справочник аудитных логов {{ vpc-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ vpc-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane). Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.network.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [vpc-events](../_includes/audit-trails/events/vpc-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [vpc-events-dp](../_includes/audit-trails/events/vpc-events-dp.md) %}