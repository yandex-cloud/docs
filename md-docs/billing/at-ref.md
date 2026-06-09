# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ billing-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.billing.<имя_события>
```

Имя события | Описание
--- | ---
`BillingAccountCreate` | Создание платежного аккаунта
`BillingAccountUpdate` | Изменение платежного аккаунта