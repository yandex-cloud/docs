# Триггер для {{ cloud-logging-full-name }}

Триггер для {{ cloud-logging-full-name }} запускает [контейнер](../container.md) {{ serverless-containers-name }}, когда в [лог-группу](../../../logging/concepts/log-group.md) добавляют записи.

## Роли, необходимые для корректной работы триггера для {{ cloud-logging-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль:
    * `serverless.containers.invoker` на контейнер, который вызывает триггер.
    * `logging.reader` на лог-группу, при добавлении записей в которую вызывается триггер.

## Формат сообщения от триггера для {{ cloud-logging-name }} {#format}

После того как триггер сработает, он отправит в контейнер следующее сообщение:

```
{
   "messages":[
      {
         "event_metadata":{
            "event_id":"2c59a567-6666-4b65-a0b0-cc**********",
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
                     "id":"b09tm9raoe**********"
                  },
                  "timestamp":"2021-09-02 18:29:17.118082213 +0000 UTC",
                  "level":"INFO",
                  "message":"START RequestID: 085035c7-2319-40dd-bb03-fd********** Version: b09s5cq4b935********",
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
## См. также {#see-also_}

* [Триггер для {{ cloud-logging-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/cloud-logging-trigger.md).