---
title: Справочник аудитных логов {{ container-registry-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ container-registry-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ container-registry-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.containerregistry.<имя_события>
```

{% include [container-registry-events](../_includes/audit-trails/events/container-registry-events.md) %}