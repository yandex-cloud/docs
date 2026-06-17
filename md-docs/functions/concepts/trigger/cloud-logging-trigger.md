# Триггер для Cloud Logging, который вызывает функцию Cloud Functions

[Триггер](index.md) для Cloud Logging запускает [функцию](../function.md) Cloud Functions, когда в [лог-группу](../../../logging/concepts/log-group.md) добавляют записи.

Триггеру для Cloud Logging необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для чтения из лог-группы и вызова функции.

О том, как создать триггер для Cloud Logging, читайте в инструкции [Создать триггер для Cloud Logging, который вызывает функцию Cloud Functions](../../operations/trigger/cloud-logging-trigger-create.md).

## Группирование сообщений {#batching}

Настройки группирования позволяют передавать в функцию сразу несколько сообщений. Эти настройки задают ограничение сверху по размеру группы сообщений и по времени ее накопления. Например, если размер группы сообщений равен 3, то в функцию могут поступать группы, в которых содержится от 1 до 3 сообщений.

## Роли, необходимые для корректной работы триггера для Cloud Logging {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходимы роли:
    * `functions.functionInvoker` на функцию, которую вызывает триггер.
    * `logging.reader` на лог-группу, при добавлении записей в которую вызывается триггер.

## Формат сообщения от триггера для Cloud Logging {#format}

После того как триггер сработает, он отправит в функцию следующее сообщение:

```json
{
   "messages":[
      {
         "event_metadata":{
            "event_id":"2c59a567-6666-4b65-a0b0-cc12********",
            "event_type":"yandex.cloud.events.serverless.triggers.LoggingMessageBatch",
            "created_at":{
               "seconds":1630607359,
               "nanos":6794776
            }
         },
         "details":{
            "messages":[
               {
                  "resource":{
                     "type":"serverless.function",
                     "id":"b09tm9raoev5********"
                  },
                  "timestamp":"2021-09-02 18:29:17.118082213 +0000 UTC",
                  "level":"INFO",
                  "message":"START RequestID: 085035c7-2319-40dd-bb03-fd8t******** Version: b09s5cq4b935********",
                  "json_payload":{
                     "request_id":"085035c7-2319-40dd-bb03-fdb2********",
                     "version_id":"b09s5cq4b935********"
                  }
               }
            ]
         }
      }
   ]
}
```

## Примеры использования {#examples}

* [Настройка реагирования в Yandex Cloud Logging и Cloud Functions](../../tutorials/logging-functions.md)
* [Запись логов балансировщика в PostgreSQL](../../tutorials/logging.md)

## Полезные ссылки {#see-also}

* [Триггер для Cloud Logging, который вызывает контейнер Serverless Containers](../../../serverless-containers/concepts/trigger/cloud-logging-trigger.md)
* [Триггер для Cloud Logging, который отправляет сообщения в WebSocket-соединения](../../../api-gateway/concepts/trigger/cloud-logging-trigger.md)