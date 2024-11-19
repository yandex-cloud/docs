---
title: Справочник аудитных логов {{ network-load-balancer-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ network-load-balancer-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ network-load-balancer-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.loadbalancer.<имя_события>
```

{% include [network-load-balancer-events](../_includes/audit-trails/events/network-load-balancer-events.md) %}