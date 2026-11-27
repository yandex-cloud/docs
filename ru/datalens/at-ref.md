---
title: Справочник аудитных логов {{ datalens-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий уровня сервисов и конфигурации {{ datalens-name }}, отслеживаемых в {{ at-name }}.
alternate:
  - href: ru/datalens/at-ref.md
    type: text/markdown
    title: Markdown version
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ datalens-full-name }} поддерживается отслеживание [событий уровня конфигурации]({{ link-docs }}/audit-trails/concepts/format) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.datalens.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [datalens-events](../_includes/audit-trails/events/datalens-events.md) %}
