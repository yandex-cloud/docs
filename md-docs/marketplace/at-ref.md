[Документация Yandex Cloud](../index.md) > [Yandex Cloud Marketplace](index.md) > Пользователям > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации для Yandex Cloud Marketplace. Подробнее в [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.marketplace.licensemanager.<имя_события>
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