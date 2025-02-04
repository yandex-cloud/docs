---
title: Справочник аудитных логов {{ mrd-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ mrd-name }}, отслеживаемых в {{ at-name }}.
---


# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ mrd-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.mdb.redis.<имя_события>
```


## Справочник событий уровня конфигурации {#control-plane-events}

{% include [mrd-events](../_includes/audit-trails/events/mrd-events.md) %}


## Справочник событий уровня сервисов {#data-plane-events}

{% include [mrd-events-dp](../_includes/audit-trails/events/mrd-events-dp.md) %}