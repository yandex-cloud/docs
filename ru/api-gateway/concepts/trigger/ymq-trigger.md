# Триггер для {{ message-queue-short-name }}, который отправляет сообщения в WebSocket-соединения

[Триггер](../trigger/) для {{ message-queue-short-name }} предназначен для разгрузки [очереди сообщений](../../../message-queue/concepts/queue.md). Он принимает сообщения из очереди и передает их в [WebSocket-соединения](../extensions/websocket.md).

{% include [ymq-trigger-note.md](../../../_includes/functions/ymq-trigger-note.md) %}

Запросы к очереди сообщений при работе триггера не тарифицируются.

Триггеру для {{ message-queue-short-name }} необходимы [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для чтения из очереди сообщений и отправки сообщения в WebSocket-соединения. Вы можете использовать один и тот же сервисный аккаунт для обеих операций. 

О том, как создать триггер для {{ message-queue-short-name }}, читайте в инструкции [{#T}](../../operations/trigger/ymq-trigger-create.md).

## Роли, необходимые для корректной работы триггера для {{ message-queue-short-name }} {#roles}

* Для создания триггера вам необходимы: 
    * Роль `{{ roles-viewer }}` на каталог с очередью сообщений, из которой триггер читает сообщения.
    * Роль `{{ roles-viewer }}` на каталог с API-шлюзом, в веб-сокет соединения подключенные к которому триггер рассылает сообщения.
    * Разрешение на сервисный аккаунт, от имени которого триггер выполняет операции. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
* Для работы триггера сервисным аккаунтам необходимы роли: 
    * `{{ roles-editor }}` на каталог с очередью сообщений, из которой триггер читает сообщения.
    * `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ message-queue-short-name }} {#format}

После того как триггер примет сообщение из очереди, он отправит его в WebSocket-соединения в следующем формате: 

{% include [ymq-format](../../../_includes/functions/ymq-format.md) %}

## См. также {#see-also}

* [Триггер для {{ message-queue-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/ymq-trigger.md)
* [Триггер для {{ message-queue-name }}, который передает сообщения в функцию {{ sf-name }}](../../../functions/concepts/trigger/ymq-trigger.md)
