[Документация Yandex Cloud](../index.md) > [Yandex IoT Core](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](sunset.md).

{% endnote %}

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex IoT Core. Подробнее в [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.iot.<имя_события>
```

Имя события | Описание
--- | ---
`broker.AddBrokerCertificate` | Добавление сертификата брокера
`broker.AddBrokerPassword` | Добавление пароля брокера
`broker.CreateBroker` | Создание брокера
`broker.DeleteBroker` | Удаление брокера
`broker.DeleteBrokerCertificate` | Удаление сертификата брокера
`broker.DeleteBrokerPassword` | Удаление пароля брокера
`broker.UpdateBroker` | Изменение брокера
`devices.AddDeviceCertificate` | Добавление сертификата устройства
`devices.AddDevicePassword` | Добавление пароля устройства
`devices.AddRegistryCertificate` | Добавление сертификата реестра
`devices.AddRegistryPassword` | Добавление пароля реестра
`devices.CreateDevice` | Создание устройства
`devices.CreateRegistry` | Создание реестра
`devices.DeleteDevice` | Удаление устройства
`devices.DeleteDeviceCertificate` | Удаление сертификата устройства
`devices.DeleteDevicePassword` | Удаление пароля устройства
`devices.DeleteRegistry` | Удаление реестра
`devices.DeleteRegistryCertificate` | Удаление сертификата реестра
`devices.DeleteRegistryPassword` | Удаление пароля реестра
`devices.UpdateDevice` | Изменение устройства
`devices.UpdateRegistry` | Изменение реестра