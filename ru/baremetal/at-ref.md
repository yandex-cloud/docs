---
title: Справочник аудитных логов {{ baremetal-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ baremetal-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ baremetal-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.baremetal.<имя_события>
```

{% include [about-events-ref](../_includes/audit-trails/about-events-ref.md) %}

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [baremetal-events](../_includes/audit-trails/events/baremetal-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [compute-events-dp](../_includes/audit-trails/events/baremetal-events-dp.md) %}