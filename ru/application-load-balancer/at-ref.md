# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ alb-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Значение поля `event_type` (_тип события_) определяется сервисом-источником события.

Общий вид значения:

```text
{{ at-event-prefix }}.audit.apploadbalancer.<имя_события>
```

{% include [alb-events](../_includes/audit-trails/events/alb-events.md) %}
