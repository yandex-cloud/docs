---
title: Справочник аудитных логов {{ captcha-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ captcha-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ captcha-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.smartcaptcha.<имя_события>
```

{% include [captcha-events](../_includes/audit-trails/events/captcha-events.md) %}
