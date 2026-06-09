# Триггер для {{ cloud-logging-name }}, который отправляет сообщения в WebSocket-соединения

[Триггер](index.md) для {{ cloud-logging-name }} отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md), когда в [лог-группу](../../../logging/concepts/log-group.md) добавляют записи.

Триггеру для {{ cloud-logging-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для чтения из лог-группы и отправки сообщений в WebSocket-соединения.

О том, как создать триггер для {{ cloud-logging-name }}, читайте в инструкции [{#T}](../../operations/trigger/cloud-logging-trigger-create.md).

## Группирование сообщений {#batching}

Настройки группирования позволяют передавать в WebSocket-соединения сразу несколько сообщений. Эти настройки задают ограничение сверху по размеру группы сообщений и по времени ее накопления. Например, если размер группы сообщений равен 3, то в WebSocket-соединения могут поступать группы, в которых содержится от 1 до 3 сообщений.

## Роли, необходимые для корректной работы триггера для {{ cloud-logging-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходимы роли:
    * `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.
    * `logging.reader` на лог-группу, при добавлении записей в которую вызывается триггер.

## Формат сообщения от триггера для {{ cloud-logging-name }} {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

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

## См. также {#see-also}

* [Триггер для {{ cloud-logging-name }}, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/cloud-logging-trigger.md)
* [Триггер для {{ cloud-logging-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/cloud-logging-trigger.md)