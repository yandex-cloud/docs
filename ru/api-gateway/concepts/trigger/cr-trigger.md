# Триггер для {{ container-registry-name }}, который отправляет сообщения в WebSocket-соединения

[Триггер](../trigger/) для {{ container-registry-name }} отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md), когда с [Docker-образом](../../../container-registry/concepts/docker-image.md) {{ container-registry-name }} происходят определенные события. Триггер должен находиться в одном облаке с [реестром](../../../container-registry/concepts/registry.md), на события которого он подписан.

Триггеру для {{ container-registry-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для отправки сообщений в WebSocket-соединения.

О том, как создать триггер для {{ container-registry-name }}, читайте в инструкции [{#T}](../../operations/trigger/cr-trigger-create.md).

{% include [cr-event](../../../_includes/functions/cr-event.md) %}

{% include [batching-events](../../../_includes/api-gateway/batching-events.md) %}

## Роли, необходимые для корректной работы триггера для {{ container-registry-name }} {#roles}

* Для создания триггера вам необходимы:
    * Разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
    * Роль `{{ roles-cr-puller }}` на реестр, события которого триггер обрабатывает.
* Для работы триггера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ container-registry-name }} {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

{% include [cr-format](../../../_includes/functions/cr-format.md) %}

## См. также {#see-also}

* [Триггер для {{ container-registry-name }}, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/cr-trigger.md)
* [Триггер для {{ container-registry-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/cr-trigger.md)