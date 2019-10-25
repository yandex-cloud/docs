# Триггеры

{% include [triggers-preview](../../_includes/functions/triggers-preview-stage.md) %}

_Триггер_ — условие, при наступлении которого автоматически запускается определенная функция. Триггеры позволяют автоматизировать работу с другими сервисами Яндекс.Облака.

На стадии Preview доступны следующие типы триггеров: 
 - [Триггер для очередей сообщений сервиса {{ message-queue-full-name }}](#ymq-trigger).
 - [Триггер для сообщений сервиса {{ iot-short-name }}](#iot-trigger).

## Триггер для {{ message-queue-short-name }} {#ymq-trigger}

Триггер для {{ message-queue-short-name }} предзназначен для разгрузки очереди сообщений. Он забирает сообщения из очереди и передает их в функцию для обработки. Триггер должен находиться в одном облаке с очередью, из которой он читает сообщения. Для одной очереди сообщений можно создать только один триггер. 

Триггеру для {{ message-queue-short-name }} необходимы сервисные аккаунты для чтения из очереди сообщений и вызова функции. Вы можете использовать один и тот же сервисный аккаунт для обеих операций. 

### Роли, необходимые для корректной работы триггера для {{ message-queue-short-name }} {#ymq-role}

- Для создания триггера вам необходимы роли: 
    - `{{ roles-viewer }}` на каталог с очередью сообщений, из которой триггер читает сообщения.
    - `{{ roles-viewer }}` на каталог с функцией, которую триггер вызывает.
    - `iam.serviceAccounts.user` на сервисные аккаунты, от имени которых триггер выполняют операции.
- Для работы триггера сервисным аккаунтам необходимы роли: 
    - `{{ roles-viewer }}` на каталог с очередью сообщений, из которой триггер читает сообщения.
    - `{{ roles-functions-ivoker }}` на каталог с функцией, которую триггер вызывает.

## Триггер для {{ iot-short-name }} {#iot-trigger}

{% include [iot-core](../../_includes/functions/iot-core-trigger-description.md) %}

### Роли, необходимые для корректной работы триггера для {{ iot-short-name }} {#iotrole}

Для работы триггера сервисному аккаунту необходима роль `{{ roles-functions-ivoker }}` на каталог с функцией, которую триггер вызывает.

Подробнее об [управлении доступом](../security/index.md).

Триггеры вызывают функции для обработки сообщений согласно установленным [квотам и лимитам](limits.md).

## Особенности вызова функции триггером {#invoke}

При вызове функции триггером существуют следующие особенности:
- Функция вызывается триггером всегда с параметром строки запроса `integration=raw`. Подробнее о [вызове функции](../../functions/concepts/function-invoke.md).
- Триггер приводит сообщения к [определенному формату перед передачей функции](#message-format). 

### Формат сообщения, которое получит функция {#message-format}

Триггер передает сообщение функции в измененном формате, определенном для каждого триггера:
- [Формат сообщения от триггера {{ message-queue-short-name }}](#ymq-format)
- [Формат сообщения от триггера {{ iot-short-name }}](#iot-format)

#### Формат сообщения от триггера {{ message-queue-short-name }} {#ymq-format}

После того, как триггер заберет сообщений из очереди, он передаст его в функцию в следующем формате: 

```json
{
   "messages":[
      {
         "event_metadata":{
            "event_id":"cce76685-5828-4304-a83d-95643c0507a0",
            "event_type":"yandex.cloud.events.messagequeue.QueueMessage",
            "created_at":"2019-09-24T00:54:28.980441Z"
         },
         "details":{
            "queue_id": "yrn:yc:ymq:ru-central1:21i6v06sqmsaoeon7nus:event-queue",
            "message":{
               "message_id":"cce76685-5828-4304-a83d-95643c0507a0",
               "md5_of_body":"d29343907090dff4cec4a9a0efb80d20",
               "body":"message body",
               "attributes":{
                  "SentTimestamp":"1569285804456"
               },
               "message_attributes":{
                  "messageAttributeKey":{
                     "dataType":"StringValue",
                     "stringValue":"value"
                  }
               },
               "md5_of_message_attributes":"83eb2d0afefb150c1ffe69f66c3de068"
            }
         }
      },
      {
         "event_metadata":{
            "event_id":"1f32fd25-11fc-4c08-88e7-d871d6ffb91d",
            "event_type":"yandex.cloud.events.messagequeue.QueueMessage",
            "created_at":"2019-09-24T00:54:28.980492Z"
         },
         "details":{
            "queue_id": "yrn:yc:ymq:ru-central1:21i6v06sqmsaoeon7nus:event-queue",
            "message":{
               "message_id":"1f32fd25-11fc-4c08-88e7-d871d6ffb91d",
               "md5_of_body":"d29343907090dff4cec4a9a0efb80d20",
               "body":"message body",
               "attributes":{
                  "SentTimestamp":"1569285806456"
               },
               "message_attributes":{
                  "messageAttributeKey":{
                     "dataType":"StringValue",
                     "stringValue":"value"
                  }
               },
               "md5_of_message_attributes":"83eb2d0afefb150c1ffe69f66c3de068"
            }
         }
      }
   ]
}
```

#### Формат сообщения от триггера {{ iot-short-name }} {#iot-format}

После того, как триггер заберет копию сообщения из топика, он передаст его в функцию в следующем формате: 

```json
{
    "messages": [
        {
            "event_metadata": {
                 "event_id": "2153b5d2-c6af-4c69-a28d-74ce965b7613",
                 "event_type": "yandex.cloud.events.iot.IoTMessage",
                 "created_at": "2019-09-25T15:51:17.872320525Z"
            },
            "details": {
                 "registry_id": "arenou2oj4ct42eq8g3n",
                 "device_id": "areqjd6un3afc3cefcvm",
                 "mqtt_topic": "$devices/areqjd6un3afc3cefcvm/events",
                 "payload": "VGVzdCA0"
            }
        },
        {
            "event_metadata": {
                 "event_id": "2153b5d2-c6af-4c69-a28d-74ce965b7613",
                 "event_type": "yandex.cloud.events.iot.IoTMessage",
                 "created_at": "2019-09-25T15:51:17.872320525Z"
            },
            "details": {
                 "registry_id": "arenou2oj4ct42eq8g3n",
                 "device_id": "areqjd6un3afc3cefcvm",
                 "mqtt_topic": "$devices/areqjd6un3afc3cefcvm/events",
                 "payload": "VGVzdCA0"
            }
        }
    ]
}
```
