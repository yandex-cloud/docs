# Триггер для {{ objstorage-name }}, который отправляет сообщения в WebSocket-соединения

[Триггер](../trigger/) для {{ objstorage-name }} отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md), когда наступает определенное событие с [объектом](../../../storage/concepts/object.md) {{ objstorage-name }}. Триггер должен находиться в одном облаке с бакетом, на события которого он подписан.

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

{% include [batching-events](../../../_includes/api-gateway/batching-events.md) %}

## Роли, необходимые для корректной работы триггера для {{ objstorage-name }} {#roles}

- Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
- Для работы триггера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ objstorage-name }} {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

{% include [os-format](../../../_includes/functions/os-format.md) %}

## См. также {#see-also}

* [Триггер для {{ objstorage-name }}, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/os-trigger.md)
* [Триггер для {{ objstorage-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/os-trigger.md)
