---
title: Справочник аудитных логов {{ lockbox-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ lockbox-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ lockbox-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.lockbox.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [lockbox-events](../_includes/audit-trails/events/lockbox-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [lockbox-events-dp](../_includes/audit-trails/events/lockbox-events-dp.md) %}