# Триггер для {{ objstorage-name }}, который отправляет сообщения в WebSocket-соединения

[Триггер](index.md) для {{ objstorage-name }} отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md), когда наступает определенное событие с [объектом](../../../storage/concepts/object.md) {{ objstorage-name }}. Триггер должен находиться в одном облаке с бакетом, на события которого он подписан.

Триггеру для {{ objstorage-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для отправки сообщений в WebSocket-соединения.

О том, как создать триггер для {{ objstorage-name }}, читайте в инструкции [{#T}](../../operations/trigger/os-trigger-create.md).

## События для настройки триггера {#event}

События с объектами в бакете, которые можно отслеживать с помощью триггера:
- [Создание объекта](../../../storage/operations/objects/upload.md).
- [Редактирование ACL объекта](../../../storage/operations/objects/edit-acl.md).
- [Удаление объекта](../../../storage/operations/objects/delete.md).

### Фильтрация событий по объектам {#filter}

События фильтруются с помощью префиксов и суффиксов для [ключа](../../../storage/concepts/object.md#key) объекта:
* Префикс — это часть ключа объекта, которая содержит начало ключа объекта. 
* Суффикс — это часть ключа объекта, которая содержит конец ключа объекта. 

Префикс и суффикс могут быть произвольной длины. При использовании префикса и суффикса одновременно, фильтрация происходит по принципу логического `И`: чтобы триггер сработал, ключ объекта должен подходить и по префиксу, и по суффиксу. 

## Группирование событий {#batching}

Настройки группирования позволяют отправлять в WebSocket-соединения сразу несколько событий. Эти настройки задают ограничение сверху по размеру группы событий и по времени ее накопления. Например, если размер группы событий равен 3, то в WebSocket-соединения могут отправляться группы, в которых содержится от 1 до 3 событий.

## Роли, необходимые для корректной работы триггера для {{ objstorage-name }} {#roles}

- Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
- Для работы триггера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ objstorage-name }} {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

```json
{
  "messages": [
    {
      "event_metadata": {
        "event_id": "bb1dd06d-a82c-49b4-af98-d8e0********",
        "event_type": "yandex.cloud.events.storage.ObjectDelete",
        "created_at": "2019-12-19T14:17:47.847365Z",
        "tracing_context": {
          "trace_id": "dd52ace7********",
          "span_id": "",
          "parent_span_id": ""
        },
        "cloud_id": "b1gvlrnlei4l********",
        "folder_id": "b1g88tflru0e********"
      },
      "details": {
        "bucket_id": "s3-for-trigger",
        "object_id": "dev/0_15a775_972dbde4_orig12.jpg"
      }
    }
  ]
}
```

## См. также {#see-also}

* [Триггер для {{ objstorage-name }}, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/os-trigger.md)
* [Триггер для {{ objstorage-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/os-trigger.md)