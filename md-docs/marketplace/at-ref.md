# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации для {{ marketplace-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.marketplace.licensemanager.<имя_события>
```

Имя события | Описание
--- | ---
`ActivateSubscriptionAutoRenewal` | Активация автоматического продления подписки
`CancelSubscriptionAutoRenewal` | Отмена автоматического продления подписки
`CreateLicenseInstance` | Покупка подписки
`DeleteLicenseInstance` | Удаление подписки
`LockLicenseInstance` | Привязка подписки
`MoveLicenseInstance` | Перемещение подписки
`UnlockLicenseInstance` | Отмена привязки подписки