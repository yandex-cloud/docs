# Yandex IoT Core

Сервис Yandex IoT Core больше не доступен для новых пользователей.

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу.

Подробнее о сроках и порядке закрытия читайте на странице <a href="sunset.md">Закрытие сервиса</a>.

# Yandex IoT Core

 - [Закрытие сервиса](sunset.md)

## Начало работы

 - [Обзор](quickstart-overview.md)

 - [Реестр устройств](quickstart.md)

 - [Брокер](quickstart-broker.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Отправка сообщения](operations/publish.md)

 - [Подписка устройства или реестра на получение сообщений](operations/subscribe.md)

 - [Экспорт сообщений в Data Streams](operations/yds-export.md)

 - [Просмотр журнала подключений](operations/logs.md)

### Создание триггера для топика

 - [Реестр устройств](operations/trigger-create.md)

 - [Брокер](operations/trigger-broker-create.md)

### Управление реестрами

 - [Получение информации о реестре](operations/registry/registry-list.md)

 - [Создание реестра](operations/registry/registry-create.md)

 - [Изменение реестра](operations/registry/registry-update.md)

 - [Отключение и включение реестра](operations/registry/registry-disabling.md)

 - [Удаление реестра](operations/registry/registry-delete.md)

### Управление устройствами

#### Управление алиасами топиков

 - [Создание алиаса](operations/device/alias/alias-create.md)

 - [Получение списка алиасов](operations/device/alias/alias-list.md)

 - [Изменение алиаса](operations/device/alias/alias-update.md)

 - [Удаление алиаса](operations/device/alias/alias-delete.md)

 - [Получение информации об устройстве](operations/device/device-list.md)

 - [Создание устройства](operations/device/device-create.md)

 - [Изменение устройства](operations/device/device-update.md)

 - [Удаление устройства](operations/device/device-delete.md)

### Управление брокерами

 - [Получение информации о брокере](operations/broker/broker-list.md)

 - [Создание брокера](operations/broker/broker-create.md)

 - [Изменение брокера](operations/broker/broker-update.md)

 - [Удаление брокера](operations/broker/broker-delete.md)

### Управление сертификатами

 - [Создание сертификата](operations/certificates/create-certificates.md)

 - [Управление сертификатами реестра](operations/certificates/registry-certificates.md)

 - [Управление сертификатами устройства](operations/certificates/device-certificates.md)

 - [Управление сертификатами брокера](operations/certificates/broker-certificates.md)

### Управление паролями

 - [Управление паролями реестра](operations/password/registry-password.md)

 - [Управление паролями устройства](operations/password/device-password.md)

 - [Управление паролями брокера](operations/password/broker-password.md)

 - [Просмотр операций с ресурсами сервиса](operations/operation-logs.md)

## Концепции

 - [Аутентификация](concepts/authorization.md)

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Параметры подключения MQTT-сервера](concepts/mqtt-properties.md)

 - [Отправка сообщений MQTT-серверу через gRPC](concepts/mqtt-grpc.md)

### Топик

 - [Обзор](concepts/topic/index.md)

 - [Топики устройства](concepts/topic/devices-topic.md)

 - [Топики реестра](concepts/topic/registries-topic.md)

 - [Сабтопик](concepts/topic/subtopic.md)

 - [Использование топиков](concepts/topic/usage.md)

 - [Резервное копирование](concepts/backup.md)

 - [Квоты и лимиты](concepts/limits.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Работа с помощью Mosquitto

 - [Отправить сообщение](tutorials/mosquitto/mosquitto-publish.md)

 - [Подписать устройство или реестр на получение сообщений](tutorials/mosquitto/mosquitto-subscribe.md)

 - [Работа с Yandex IoT Core с устройства с Android на языке Java](tutorials/android-java.md)

 - [Работа с Yandex IoT Core на языке C#](tutorials/c-sharp.md)

 - [Работа с Yandex IoT Core на языке Java](tutorials/java.md)

 - [Запись данных с устройства в базу данных](tutorials/data-recording.md)

 - [Мониторинг состояния географически распределенных устройств](tutorials/datalens.md)

 - [Мониторинг показаний датчиков и уведомления о событиях](tutorials/monitoring.md)

 - [Тестирование доставки сообщения](tutorials/message-delivery-check.md)

 - [Эмуляция множества IoT-устройств](tutorials/iot-emulation.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### broker

 - [Overview](cli-ref/broker/index.md)

 - [add-labels](cli-ref/broker/add-labels.md)

#### certificate

 - [Overview](cli-ref/broker/certificate/index.md)

 - [add](cli-ref/broker/certificate/add.md)

 - [delete](cli-ref/broker/certificate/delete.md)

 - [list](cli-ref/broker/certificate/list.md)

 - [create](cli-ref/broker/create.md)

 - [delete](cli-ref/broker/delete.md)

 - [get](cli-ref/broker/get.md)

 - [list](cli-ref/broker/list.md)

 - [logs](cli-ref/broker/logs.md)

#### password

 - [Overview](cli-ref/broker/password/index.md)

 - [add](cli-ref/broker/password/add.md)

 - [delete](cli-ref/broker/password/delete.md)

 - [list](cli-ref/broker/password/list.md)

 - [remove-labels](cli-ref/broker/remove-labels.md)

 - [update](cli-ref/broker/update.md)

### device

 - [Overview](cli-ref/device/index.md)

 - [add-topic-aliases](cli-ref/device/add-topic-aliases.md)

#### certificate

 - [Overview](cli-ref/device/certificate/index.md)

 - [add](cli-ref/device/certificate/add.md)

 - [delete](cli-ref/device/certificate/delete.md)

 - [list](cli-ref/device/certificate/list.md)

 - [create](cli-ref/device/create.md)

 - [delete](cli-ref/device/delete.md)

 - [get](cli-ref/device/get.md)

 - [list](cli-ref/device/list.md)

 - [logs](cli-ref/device/logs.md)

#### password

 - [Overview](cli-ref/device/password/index.md)

 - [add](cli-ref/device/password/add.md)

 - [delete](cli-ref/device/password/delete.md)

 - [list](cli-ref/device/password/list.md)

 - [remove-topic-aliases](cli-ref/device/remove-topic-aliases.md)

 - [update](cli-ref/device/update.md)

### mqtt

 - [Overview](cli-ref/mqtt/index.md)

 - [publish](cli-ref/mqtt/publish.md)

 - [subscribe](cli-ref/mqtt/subscribe.md)

### registry

 - [Overview](cli-ref/registry/index.md)

 - [add-labels](cli-ref/registry/add-labels.md)

#### certificate

 - [Overview](cli-ref/registry/certificate/index.md)

 - [add](cli-ref/registry/certificate/add.md)

 - [delete](cli-ref/registry/certificate/delete.md)

 - [list](cli-ref/registry/certificate/list.md)

 - [create](cli-ref/registry/create.md)

 - [delete](cli-ref/registry/delete.md)

 - [disable](cli-ref/registry/disable.md)

 - [enable](cli-ref/registry/enable.md)

 - [get](cli-ref/registry/get.md)

 - [list](cli-ref/registry/list.md)

 - [list-device-topic-aliases](cli-ref/registry/list-device-topic-aliases.md)

 - [logs](cli-ref/registry/logs.md)

#### password

 - [Overview](cli-ref/registry/password/index.md)

 - [add](cli-ref/registry/password/add.md)

 - [delete](cli-ref/registry/password/delete.md)

 - [list](cli-ref/registry/password/list.md)

 - [remove-labels](cli-ref/registry/remove-labels.md)

 - [update](cli-ref/registry/update.md)

#### yds-export

 - [Overview](cli-ref/registry/yds-export/index.md)

 - [add](cli-ref/registry/yds-export/add.md)

 - [delete](cli-ref/registry/yds-export/delete.md)

 - [list](cli-ref/registry/yds-export/list.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### broker

 - [Overview](cli-ref/v0/broker/index.md)

 - [add-labels](cli-ref/v0/broker/add-labels.md)

##### certificate

 - [Overview](cli-ref/v0/broker/certificate/index.md)

 - [add](cli-ref/v0/broker/certificate/add.md)

 - [delete](cli-ref/v0/broker/certificate/delete.md)

 - [list](cli-ref/v0/broker/certificate/list.md)

 - [create](cli-ref/v0/broker/create.md)

 - [delete](cli-ref/v0/broker/delete.md)

 - [get](cli-ref/v0/broker/get.md)

 - [list](cli-ref/v0/broker/list.md)

 - [logs](cli-ref/v0/broker/logs.md)

##### password

 - [Overview](cli-ref/v0/broker/password/index.md)

 - [add](cli-ref/v0/broker/password/add.md)

 - [delete](cli-ref/v0/broker/password/delete.md)

 - [list](cli-ref/v0/broker/password/list.md)

 - [remove-labels](cli-ref/v0/broker/remove-labels.md)

 - [update](cli-ref/v0/broker/update.md)

#### device

 - [Overview](cli-ref/v0/device/index.md)

 - [add-topic-aliases](cli-ref/v0/device/add-topic-aliases.md)

##### certificate

 - [Overview](cli-ref/v0/device/certificate/index.md)

 - [add](cli-ref/v0/device/certificate/add.md)

 - [delete](cli-ref/v0/device/certificate/delete.md)

 - [list](cli-ref/v0/device/certificate/list.md)

 - [create](cli-ref/v0/device/create.md)

 - [delete](cli-ref/v0/device/delete.md)

 - [get](cli-ref/v0/device/get.md)

 - [list](cli-ref/v0/device/list.md)

 - [logs](cli-ref/v0/device/logs.md)

##### password

 - [Overview](cli-ref/v0/device/password/index.md)

 - [add](cli-ref/v0/device/password/add.md)

 - [delete](cli-ref/v0/device/password/delete.md)

 - [list](cli-ref/v0/device/password/list.md)

 - [remove-topic-aliases](cli-ref/v0/device/remove-topic-aliases.md)

 - [update](cli-ref/v0/device/update.md)

#### mqtt

 - [Overview](cli-ref/v0/mqtt/index.md)

 - [publish](cli-ref/v0/mqtt/publish.md)

 - [subscribe](cli-ref/v0/mqtt/subscribe.md)

#### registry

 - [Overview](cli-ref/v0/registry/index.md)

 - [add-labels](cli-ref/v0/registry/add-labels.md)

##### certificate

 - [Overview](cli-ref/v0/registry/certificate/index.md)

 - [add](cli-ref/v0/registry/certificate/add.md)

 - [delete](cli-ref/v0/registry/certificate/delete.md)

 - [list](cli-ref/v0/registry/certificate/list.md)

 - [create](cli-ref/v0/registry/create.md)

 - [delete](cli-ref/v0/registry/delete.md)

 - [disable](cli-ref/v0/registry/disable.md)

 - [enable](cli-ref/v0/registry/enable.md)

 - [get](cli-ref/v0/registry/get.md)

 - [list](cli-ref/v0/registry/list.md)

 - [list-device-topic-aliases](cli-ref/v0/registry/list-device-topic-aliases.md)

 - [logs](cli-ref/v0/registry/logs.md)

##### password

 - [Overview](cli-ref/v0/registry/password/index.md)

 - [add](cli-ref/v0/registry/password/add.md)

 - [delete](cli-ref/v0/registry/password/delete.md)

 - [list](cli-ref/v0/registry/password/list.md)

 - [remove-labels](cli-ref/v0/registry/remove-labels.md)

 - [update](cli-ref/v0/registry/update.md)

##### yds-export

 - [Overview](cli-ref/v0/registry/yds-export/index.md)

 - [add](cli-ref/v0/registry/yds-export/add.md)

 - [delete](cli-ref/v0/registry/yds-export/delete.md)

 - [list](cli-ref/v0/registry/yds-export/list.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API Devices

 - [Аутентификация в API](api-ref/devices/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### DeviceData

 - [Overview](api-ref/grpc/DeviceData/index.md)

 - [Publish](api-ref/grpc/DeviceData/publish.md)

#### Device

 - [Overview](api-ref/grpc/Device/index.md)

 - [Get](api-ref/grpc/Device/get.md)

 - [GetByName](api-ref/grpc/Device/getByName.md)

 - [List](api-ref/grpc/Device/list.md)

 - [Create](api-ref/grpc/Device/create.md)

 - [Update](api-ref/grpc/Device/update.md)

 - [Delete](api-ref/grpc/Device/delete.md)

 - [ListCertificates](api-ref/grpc/Device/listCertificates.md)

 - [AddCertificate](api-ref/grpc/Device/addCertificate.md)

 - [DeleteCertificate](api-ref/grpc/Device/deleteCertificate.md)

 - [ListPasswords](api-ref/grpc/Device/listPasswords.md)

 - [AddPassword](api-ref/grpc/Device/addPassword.md)

 - [DeletePassword](api-ref/grpc/Device/deletePassword.md)

 - [ListOperations](api-ref/grpc/Device/listOperations.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### RegistryData

 - [Overview](api-ref/grpc/RegistryData/index.md)

 - [Publish](api-ref/grpc/RegistryData/publish.md)

#### Registry

 - [Overview](api-ref/grpc/Registry/index.md)

 - [Get](api-ref/grpc/Registry/get.md)

 - [GetByName](api-ref/grpc/Registry/getByName.md)

 - [List](api-ref/grpc/Registry/list.md)

 - [Create](api-ref/grpc/Registry/create.md)

 - [Update](api-ref/grpc/Registry/update.md)

 - [Delete](api-ref/grpc/Registry/delete.md)

 - [ListCertificates](api-ref/grpc/Registry/listCertificates.md)

 - [AddCertificate](api-ref/grpc/Registry/addCertificate.md)

 - [DeleteCertificate](api-ref/grpc/Registry/deleteCertificate.md)

 - [ListPasswords](api-ref/grpc/Registry/listPasswords.md)

 - [AddPassword](api-ref/grpc/Registry/addPassword.md)

 - [DeletePassword](api-ref/grpc/Registry/deletePassword.md)

 - [ListDeviceTopicAliases](api-ref/grpc/Registry/listDeviceTopicAliases.md)

 - [ListDataStreamExports](api-ref/grpc/Registry/listDataStreamExports.md)

 - [AddDataStreamExport](api-ref/grpc/Registry/addDataStreamExport.md)

 - [DeleteDataStreamExport](api-ref/grpc/Registry/deleteDataStreamExport.md)

 - [ListOperations](api-ref/grpc/Registry/listOperations.md)

 - [Disable](api-ref/grpc/Registry/disable.md)

 - [Enable](api-ref/grpc/Registry/enable.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### DeviceData

 - [Overview](api-ref/DeviceData/index.md)

 - [Publish](api-ref/DeviceData/publish.md)

#### Device

 - [Overview](api-ref/Device/index.md)

 - [Get](api-ref/Device/get.md)

 - [GetByName](api-ref/Device/getByName.md)

 - [List](api-ref/Device/list.md)

 - [Create](api-ref/Device/create.md)

 - [Update](api-ref/Device/update.md)

 - [Delete](api-ref/Device/delete.md)

 - [ListCertificates](api-ref/Device/listCertificates.md)

 - [AddCertificate](api-ref/Device/addCertificate.md)

 - [DeleteCertificate](api-ref/Device/deleteCertificate.md)

 - [ListPasswords](api-ref/Device/listPasswords.md)

 - [AddPassword](api-ref/Device/addPassword.md)

 - [DeletePassword](api-ref/Device/deletePassword.md)

 - [ListOperations](api-ref/Device/listOperations.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### RegistryData

 - [Overview](api-ref/RegistryData/index.md)

 - [Publish](api-ref/RegistryData/publish.md)

#### Registry

 - [Overview](api-ref/Registry/index.md)

 - [Get](api-ref/Registry/get.md)

 - [GetByName](api-ref/Registry/getByName.md)

 - [List](api-ref/Registry/list.md)

 - [Create](api-ref/Registry/create.md)

 - [Update](api-ref/Registry/update.md)

 - [Delete](api-ref/Registry/delete.md)

 - [ListCertificates](api-ref/Registry/listCertificates.md)

 - [AddCertificate](api-ref/Registry/addCertificate.md)

 - [DeleteCertificate](api-ref/Registry/deleteCertificate.md)

 - [ListPasswords](api-ref/Registry/listPasswords.md)

 - [AddPassword](api-ref/Registry/addPassword.md)

 - [DeletePassword](api-ref/Registry/deletePassword.md)

 - [ListDeviceTopicAliases](api-ref/Registry/listDeviceTopicAliases.md)

 - [ListOperations](api-ref/Registry/listOperations.md)

 - [Disable](api-ref/Registry/disable.md)

 - [Enable](api-ref/Registry/enable.md)

## Справочник API Broker

 - [Аутентификация в API](api-ref/broker/authentication.md)

### gRPC (англ.)

 - [Overview](broker/api-ref/grpc/index.md)

#### BrokerData

 - [Overview](broker/api-ref/grpc/BrokerData/index.md)

 - [Publish](broker/api-ref/grpc/BrokerData/publish.md)

#### Broker

 - [Overview](broker/api-ref/grpc/Broker/index.md)

 - [Get](broker/api-ref/grpc/Broker/get.md)

 - [List](broker/api-ref/grpc/Broker/list.md)

 - [Create](broker/api-ref/grpc/Broker/create.md)

 - [Update](broker/api-ref/grpc/Broker/update.md)

 - [Delete](broker/api-ref/grpc/Broker/delete.md)

 - [ListCertificates](broker/api-ref/grpc/Broker/listCertificates.md)

 - [AddCertificate](broker/api-ref/grpc/Broker/addCertificate.md)

 - [DeleteCertificate](broker/api-ref/grpc/Broker/deleteCertificate.md)

 - [ListPasswords](broker/api-ref/grpc/Broker/listPasswords.md)

 - [AddPassword](broker/api-ref/grpc/Broker/addPassword.md)

 - [DeletePassword](broker/api-ref/grpc/Broker/deletePassword.md)

 - [ListOperations](broker/api-ref/grpc/Broker/listOperations.md)

#### Operation

 - [Overview](broker/api-ref/grpc/Operation/index.md)

 - [Get](broker/api-ref/grpc/Operation/get.md)

 - [Cancel](broker/api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](broker/api-ref/index.md)

#### BrokerData

 - [Overview](broker/api-ref/BrokerData/index.md)

 - [Publish](broker/api-ref/BrokerData/publish.md)

#### Broker

 - [Overview](broker/api-ref/Broker/index.md)

 - [Get](broker/api-ref/Broker/get.md)

 - [List](broker/api-ref/Broker/list.md)

 - [Create](broker/api-ref/Broker/create.md)

 - [Update](broker/api-ref/Broker/update.md)

 - [Delete](broker/api-ref/Broker/delete.md)

 - [ListCertificates](broker/api-ref/Broker/listCertificates.md)

 - [AddCertificate](broker/api-ref/Broker/addCertificate.md)

 - [DeleteCertificate](broker/api-ref/Broker/deleteCertificate.md)

 - [ListPasswords](broker/api-ref/Broker/listPasswords.md)

 - [AddPassword](broker/api-ref/Broker/addPassword.md)

 - [DeletePassword](broker/api-ref/Broker/deletePassword.md)

 - [ListOperations](broker/api-ref/Broker/listOperations.md)

#### Operation

 - [Overview](broker/api-ref/Operation/index.md)

 - [Get](broker/api-ref/Operation/get.md)

 - [Cancel](broker/api-ref/Operation/cancel.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)