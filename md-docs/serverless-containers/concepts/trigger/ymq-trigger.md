[Документация Yandex Cloud](../../../index.md) > [Yandex Serverless Containers](../../index.md) > [Концепции](../index.md) > [Триггер](index.md) > Триггер для Message Queue

# Триггер для Message Queue, который передает сообщения в контейнер Serverless Containers

[Триггер](index.md) для Message Queue предназначен для разгрузки [очереди сообщений](../../../message-queue/concepts/queue.md). Он принимает сообщения из очереди и передает их в [контейнер](../container.md) Serverless Containers для обработки. После успешной обработки триггер удаляет сообщения из очереди, а при ошибке — возвращает сообщения в очередь через [таймаут видимости](../../../message-queue/concepts/visibility-timeout.md). Если для очереди не настроена [Dead Letter Queue](../../../message-queue/concepts/dlq.md), сообщение будет повторно передаваться в контейнер, пока успешно не обработается или не закончится срок его хранения.

{% note warning %}

* Триггер можно создать только для стандартной очереди сообщений.
* Триггер должен находиться в одном облаке с очередью, из которой он читает сообщения.
* Для одной очереди сообщений можно создать только один триггер.

{% endnote %}

Запросы к очереди сообщений при работе триггера не тарифицируются.

Триггеру для Message Queue необходимы [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для чтения из очереди сообщений и вызова контейнера. Вы можете использовать один и тот же сервисный аккаунт для обеих операций. 

О том, как создать триггер для Message Queue, читайте в инструкции [Создать триггер для Message Queue, который передает сообщения в контейнер Serverless Containers](../../operations/ymq-trigger-create.md).

## Группирование сообщений {#batching}

Настройки группирования позволяют передавать в контейнер сразу несколько сообщений. Эти настройки задают ограничение сверху по размеру группы сообщений и по времени ее накопления. Например, если размер группы сообщений равен 3, то в контейнер могут поступать группы, в которых содержится от 1 до 3 сообщений.

## Роли, необходимые для корректной работы триггера для Message Queue {#roles}

* Для создания триггера вам необходимы: 
    * Роль `viewer` на каталог с очередью сообщений, из которой триггер читает сообщения.
    * Роль `viewer` на каталог с контейнером, которые вызывает триггер.
    * Разрешение на сервисный аккаунт, от имени которого триггер выполняет операции. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
* Для работы триггера сервисным аккаунтам необходимы роли: 
    * `editor` на каталог с очередью сообщений, из которой триггер читает сообщения.
    * `serverless.containers.invoker` на каталог с контейнером, который вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера Message Queue {#format}

После того как триггер примет сообщение из очереди, он передаст его в контейнер в следующем формате: 

```json
{
   "messages":[
      {
         "event_metadata":{
            "event_id":"cce76685-5828-4304-a83d-9564********",
            "event_type":"yandex.cloud.events.messagequeue.QueueMessage",
            "created_at":"2019-09-24T00:54:28.980441Z",
            "cloud_id":"b1gvlrnlh2sd********",
            "folder_id":"b1g88tflh2sd********",         
         },
         "details":{
            "queue_id":"yrn:yc:ymq:ru-central1:21i6v06sqmsa********:event-queue",
            "message":{
               "message_id":"cce76685-5828-4304-a83d-9564********",
               "md5_of_body":"d29343907090dff4cec4a9a0********",
               "body":"message body",
               "attributes":{
                  "SentTimestamp":"1569285804456"
               },
               "message_attributes":{
                  "messageAttributeKey":{
                     "data_type":"StringValue",
                     "string_value":"value"
                  }
               },
               "md5_of_message_attributes":"83eb2d0afefb150c1ffe69f6********"
            }
         }
      },
      {
         "event_metadata":{
            "event_id":"1f32fd25-11fc-4c08-88e7-d871********",
            "event_type":"yandex.cloud.events.messagequeue.QueueMessage",
            "created_at":"2019-09-24T00:54:28.980492Z",
            "cloud_id":"b1gvlrnlh2sd********",
            "folder_id":"b1g88tflh2sd********",
         },
         "details":{
            "queue_id":"yrn:yc:ymq:ru-central1:21i6v06sqmsa********:event-queue",
            "message":{
               "message_id":"1f32fd25-11fc-4c08-88e7-d871********",
               "md5_of_body":"d29343907090dff4cec4a9a0********",
               "body":"message body",
               "attributes":{
                  "SentTimestamp":"1569285806456"
               },
               "message_attributes":{
                  "messageAttributeKey":{
                     "data_type":"StringValue",
                     "string_value":"value"
                  }
               },
               "md5_of_message_attributes":"83eb2d0afefb150c1ffe69f6********"
            }
         }
      }
   ]
}
```


## Полезные ссылки {#see-also}

* [Триггер для Message Queue, который передает сообщения в функцию Cloud Functions](../../../functions/concepts/trigger/ymq-trigger.md)
* [Триггер для Message Queue, который отправляет сообщения в WebSocket-соединения](../../../api-gateway/concepts/trigger/ymq-trigger.md)