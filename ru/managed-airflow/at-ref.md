---
title: Справочник аудитных логов {{ maf-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ maf-name }}, отслеживаемых в {{ at-name }}.
---


# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ maf-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.airflow.<имя_события>
```


## Справочник событий уровня конфигурации {#control-plane-events}

{% include [maf-events](../_includes/audit-trails/events/managed-airflow-events.md) %}