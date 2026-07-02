[Документация Yandex Cloud](../index.md) > [Yandex Cloud Billing](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Cloud Billing. Подробнее в разделе [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.billing.<имя_события>
```

Имя события | Описание
--- | ---
`BillingAccountCreate` | Создание платежного аккаунта
`BillingAccountUpdate` | Изменение платежного аккаунта