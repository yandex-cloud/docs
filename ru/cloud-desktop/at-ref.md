---
title: Справочник аудитных логов {{ cloud-desktop-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ cloud-desktop-full-name }}, отслеживаемых в {{ at-name }}.
---


# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ cloud-desktop-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.clouddesktop.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [clouddesktop-events](../_includes/audit-trails/events/clouddesktop-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [clouddesktop-events-dp](../_includes/audit-trails/events/clouddesktop-events-dp.md) %}