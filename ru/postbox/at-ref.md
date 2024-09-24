---
title: "Справочник аудитных логов {{ postbox-full-name }}"
description: "В данном разделе приведены описания аудитных событий {{ at-full-name }}, собираемых в сервисе {{ postbox-name }}."
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ postbox-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.postbox.<имя_события>
```

{% include [postbox-events](../_includes/audit-trails/events/postbox-events.md) %}