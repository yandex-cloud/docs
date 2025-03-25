---
title: Справочник аудитных логов {{ cloud-desktop-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ cloud-desktop-full-name }}, отслеживаемых в {{ at-name }}.
---


# Справочник аудитных логов {{ at-full-name }}

В {{ cloud-desktop-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane). Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.clouddesktop.<имя_события>
```


## Справочник событий уровня конфигурации {#control-plane-events}

{% include [clouddesktop-events](../_includes/audit-trails/events/clouddesktop-events.md) %}