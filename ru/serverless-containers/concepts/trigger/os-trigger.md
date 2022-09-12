# Триггер для {{ objstorage-name }}

[Триггер](../trigger/) для {{ objstorage-name }} запускает [контейнер](../container.md) {{ serverless-containers-name }}, когда наступает определенное событие с [объектом](../../../storage/concepts/object.md) {{ objstorage-full-name }}. Триггер должен находиться в одном облаке с бакетом, на события которого он подписан.

Триггеру для {{ objstorage-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова контейнера.

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

## Роли, необходимые для корректной работы триггера для {{ objstorage-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `serverless.containers.invoker` на каталог с контейнером, который вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ objstorage-name }} {#ymq-format}

После того как триггер сработает, он отправит в контейнер следующее сообщение: 

```json
{
  "messages": [
    {
      "event_metadata": {
        "event_id": "bb1dd06d-a82c-49b4-af98-d8e0c5a1d8f0",
        "event_type": "yandex.cloud.events.storage.ObjectDelete",
        "created_at": "2019-12-19T14:17:47.847365Z",
        "tracing_context": {
          "trace_id": "dd52ace79c62892f",
          "span_id": "",
          "parent_span_id": ""
        },
        "cloud_id": "b1gvlrnlei4l5idm9cbj",
        "folder_id": "b1g88tflru0ek1omtsu0"
      },
      "details": {
        "bucket_id": "s3-for-trigger",
        "object_id": "dev/0_15a775_972dbde4_orig12.jpg"
      }
    }
  ]
}
```

## См. также {#see-also_}

* [Триггер для {{ objstorage-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/os-trigger.md).