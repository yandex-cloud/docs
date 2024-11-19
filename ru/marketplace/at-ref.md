---
title: Справочник аудитных логов {{ marketplace-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ marketplace-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации для {{ marketplace-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.marketplace.licensemanager.<имя_события>
```

{% include [marketplace-events](../_includes/audit-trails/events/marketplace-events.md) %}