[Документация Yandex Cloud](../../../index.md) > [Yandex Serverless Containers](../../index.md) > [Концепции](../index.md) > [Триггер](index.md) > Триггер для Yandex IoT Core

# Триггер для Yandex IoT Core, который передает сообщения в контейнер Serverless Containers

[Триггер](index.md) для Yandex IoT Core предназначен для управления сообщениями, которыми обмениваются устройства, реестры и брокеры. Он создается для [топиков](../../../iot-core/concepts/topic/index.md): принимает из них копии сообщений и передает в контейнер Serverless Containers для обработки.
 
Триггер должен находиться в одном облаке с устройством, реестром или брокером, из топика которого он читает сообщения.

Вы можете создать триггер:
* Для [стандартного топика](../../../iot-core/concepts/topic/index.md), реализованного сервисом, кроме топика `$monitoring/<идентификатор_устройства>/json`.
* Для топика с произвольными [сабтопиками](../../../iot-core/concepts/topic/subtopic.md) и подстановочными символами.
* Для [алиаса](../../../iot-core/concepts/topic/usage.md#aliases) топика.
 
Триггеру для Yandex IoT Core необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова контейнера. 

О том, как создать триггер для Yandex IoT Core, читайте в инструкциях [Создать триггер, который передает сообщения в контейнер Serverless Containers из топика реестра или устройства Yandex IoT Core](../../operations/iot-core-trigger-create.md) и [Создать триггер, который передает сообщения в контейнер Serverless Containers из топика брокера Yandex IoT Core](../../operations/iot-core-trigger-broker-create.md).

## Группирование сообщений {#batching}

Настройки группирования позволяют передавать в контейнер сразу несколько сообщений. Эти настройки задают ограничение сверху по размеру группы сообщений и по времени ее накопления. Например, если размер группы сообщений равен 3, то в контейнер могут поступать группы, в которых содержится от 1 до 3 сообщений.

## Роли, необходимые для корректной работы триггера для Yandex IoT Core {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `serverless.containers.invoker` на каталог с контейнером, который вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера Yandex IoT Core {#format}

Перед тем как передать копию сообщения в контейнер, триггер приводит ее к указанному ниже формату.

### Устройство {#device}

```json
{
    "messages": [
        {
            "event_metadata": {
                 "event_id": "2153b5d2-c6af-4c69-a28d-74ce********",
                 "event_type": "yandex.cloud.events.iot.IoTMessage",
                 "created_at": "2019-09-25T15:51:17.872320525Z"
            },
            "details": {
                 "registry_id": "arenou2oj4ct********",
                 "device_id": "areqjd6un3af********",
                 "mqtt_topic": "$devices/areqjd6un3af********/events",
                 "payload": "VGVz****"
            }
        },
        {
            "event_metadata": {
                 "event_id": "2153b5d2-c6af-4c69-a28d-74ce********",
                 "event_type": "yandex.cloud.events.iot.IoTMessage",
                 "created_at": "2019-09-25T15:51:17.872320525Z"
            },
            "details": {
                 "registry_id": "arenou2oj4ct********",
                 "device_id": "areqjd6un3af********",
                 "mqtt_topic": "$devices/areqjd6un3af********/events",
                 "payload": "VGVz****"
            }
        }
    ]
}
```

### Брокер {#broker}

```json
{
   "messages":[
      {
         "event_metadata":{
            "event_id":"2153b5d2-c6af-4c69-a28d-74ce********",
            "event_type":"yandex.cloud.events.iot.IoTMessage",
            "created_at":"2019-09-25T15:51:17.872320525Z"
         },
         "details":{
            "broker_id":"arenou2oj4ct********",
            "mqtt_topic":"broker/topic",
            "payload":"VGVz****"
         }
      },
      {
         "event_metadata":{
            "event_id":"2153b5d2-c6af-4c69-a28d-74ce********",
            "event_type":"yandex.cloud.events.iot.IoTMessage",
            "created_at":"2019-09-25T15:51:17.872320525Z"
         },
         "details":{
            "broker_id":"arenou2oj4ct********",
            "mqtt_topic":"broker/topic",
            "payload":"VGVz****"
         }
      }
   ]
}
```

## Полезные ссылки {#see-also}

* [Триггер для Yandex IoT Core, который передает сообщения в функцию Cloud Functions](../../../functions/concepts/trigger/iot-core-trigger.md)
* [Триггер для Yandex IoT Core, который отправляет сообщения в WebSocket-соединения](../../../api-gateway/concepts/trigger/iot-core-trigger.md)