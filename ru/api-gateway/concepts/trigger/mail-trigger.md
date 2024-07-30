# Триггер для почты, который отправляет сообщения в веб-сокет WebSocket-соединения

[Триггер](../trigger/) для почты отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md), когда на электронную почту приходит письмо. Адрес электронной почты генерируется сервисом автоматически во время создания триггера.

Триггеру для почты необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для отправки сообщений в WebSocket-соединения.

О том, как создать триггер для почты, читайте в инструкции [{#T}](../../operations/trigger/mail-trigger-create.md).

{% include [batching-messages](../../../_includes/api-gateway/batching-messages.md) %}

## Роли, необходимые для корректной работы триггера для почты {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [{{ roles-editor }}](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.
* {% include [attachments-requirements](../../../_includes/functions/attachments-requirements.md) %}

## Формат сообщения от триггера для почты {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

{% include [mail-format](../../../_includes/functions/mail-format.md) %}

## См. также {#see-also}

* [Триггер для почты, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/mail-trigger.md)
* [Триггер для почты, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/mail-trigger.md)
