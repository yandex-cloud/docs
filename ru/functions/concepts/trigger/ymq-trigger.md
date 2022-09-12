# Триггер для {{ message-queue-short-name }}

[Триггер](../trigger/) для {{ message-queue-short-name }} предзназначен для разгрузки очереди сообщений. Он принимает сообщения из очереди и передает их в [функцию](../function.md) {{ sf-name }} для обработки. После успешной обработки триггер удаляет сообщения из очереди, а при ошибке — возвращает сообщения в очередь через [таймаут видимости](../../../message-queue/concepts/visibility-timeout.md). Если для очереди не настроена [Dead Letter Queue](../../../message-queue/concepts/dlq.md), сообщение будет повторно передаваться в функцию, пока успешно не обработается или не закончится срок его хранения.

Триггер можно создать только для стандартной очереди сообщений. Триггер должен находиться в одном облаке с очередью, из которой он получает сообщения. Для одной очереди сообщений можно создать только один триггер.

Триггеру для {{ message-queue-short-name }} необходимы [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для чтения из очереди сообщений и вызова функции. Вы можете использовать один и тот же сервисный аккаунт для обеих операций. 

## Роли, необходимые для корректной работы триггера для {{ message-queue-short-name }} {#roles}

* Для создания триггера вам необходимы роли: 
    * `{{ roles-viewer }}` на каталог с очередью сообщений, из которой триггер читает сообщения.
    * `{{ roles-viewer }}` на каталог с функцией, которые вызывает триггер.
    * Разрешение на сервисный аккаунт, от имени которого триггер выполняет операции. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисным аккаунтам необходимы роли: 
    * `{{ roles-editor }}` на каталог с очередью сообщений, из которой триггер читает сообщения.
    * `{{ roles-functions-ivoker }}` на каталог с функцией, которую вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ message-queue-short-name }} {#ymq-format}

После того как триггер примет сообщение из очереди, он передаст его в функцию в следующем формате: 

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
            "queue_id": "yrn:yc:ymq:{{ region-id }}:21i6v06sqmsaoeon7nus:event-queue",
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
            "queue_id": "yrn:yc:ymq:{{ region-id }}:21i6v06sqmsaoeon7nus:event-queue",
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

## См. также {#see-also_}

* [Триггер для {{ message-queue-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/ymq-trigger.md).