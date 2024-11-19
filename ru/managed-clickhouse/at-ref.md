---
title: Справочник аудитных логов {{ mch-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ mch-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.clickhouse.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [mch-events](../_includes/audit-trails/events/mch-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [mch-events-dp](../_includes/audit-trails/events/mch-events-dp.md) %}

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
