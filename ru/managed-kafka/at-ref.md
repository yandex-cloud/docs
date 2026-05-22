---
title: Справочник аудитных логов {{ mkf-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ mkf-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ mkf-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.kafka.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [managed-kafka-events](../_includes/audit-trails/events/managed-kafka-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [mkf-events-dp](../_includes/audit-trails/events/mkf-events-dp.md) %}