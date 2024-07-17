# Триггер для {{ cloud-logging-name }}, который отправляет сообщения в WebSocket-соединения

[Триггер](../trigger/) для {{ cloud-logging-name }} отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md), когда в [лог-группу](../../../logging/concepts/log-group.md) добавляют записи.

Триггеру для {{ cloud-logging-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для чтения из лог-группы и отправки сообщений в WebSocket-соединения.

О том, как создать триггер для {{ cloud-logging-name }}, читайте в инструкции [{#T}](../../operations/trigger/cloud-logging-trigger-create.md).

{% include [batching-messages](../../../_includes/api-gateway/batching-messages.md) %}

## Роли, необходимые для корректной работы триггера для {{ cloud-logging-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходимы роли:
    * `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.
    * `logging.reader` на лог-группу, при добавлении записей в которую вызывается триггер.

## Формат сообщения от триггера для {{ cloud-logging-name }} {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

{% include [logging-format](../../../_includes/functions/logging-format.md) %}

## См. также {#see-also}

* [Триггер для {{ cloud-logging-name }}, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/cloud-logging-trigger.md)
* [Триггер для {{ cloud-logging-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/cloud-logging-trigger.md)
