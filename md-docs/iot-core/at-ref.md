# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex IoT Core. Подробнее см. [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

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