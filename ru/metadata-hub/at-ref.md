---
title: Справочник аудитных логов {{ metadata-hub-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ metadata-hub-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ metadata-hub-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ metastore-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.metastore.<имя_события>
```

{% include [hive-metastore-events](../_includes/audit-trails/events/hive-metastore-events.md) %}