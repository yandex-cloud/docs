---
title: Справочник аудитных логов {{ msp-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ msp-name }}, отслеживаемых в {{ at-name }}.
---


# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ msp-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.spark.<имя_события>
```


## Справочник событий уровня конфигурации {#control-plane-events}

{% include [msp-events](../_includes/audit-trails/events/managed-spark-events.md) %}