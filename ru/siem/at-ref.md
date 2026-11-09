---
title: Справочник аудитных логов {{ yandex-siem-full-name }} в {{ at-full-name }}
description: События {{ yandex-siem-full-name }}, отслеживаемые в {{ at-name }}.
---

# Справочник аудитных логов {{ yandex-siem-full-name }}

В {{ at-name }} для {{ yandex-siem-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.siem.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [siem-events](../_includes/audit-trails/events/siem-events.md) %}
