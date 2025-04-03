---
title: Справочник аудитных логов {{ baremetal-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ baremetal-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ baremetal-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.baremetal.<имя_события>
```

{% include [baremetal-events](../_includes/audit-trails/events/baremetal-events.md) %}