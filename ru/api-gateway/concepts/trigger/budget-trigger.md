# Триггер для бюджетов, который отправляет сообщения в WebSocket-соединения

[Триггер](../trigger/) для [бюджетов](../../../billing/concepts/budget.md) отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md) при превышении пороговых значений.

Триггеру для бюджетов необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для отправки сообщений в WebSocket-соединения.

О том, как создать триггер для бюджетов, читайте в инструкции [{#T}](../../operations/trigger/budget-trigger-create.md).

## Роли, необходимые для корректной работы триггера для бюджетов {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

## Формат сообщения от триггера для бюджетов {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

{% include [budget-format](../../../_includes/functions/budget-format.md) %}

## См. также {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/budget-trigger.md)
* [{#T}](../../../functions/concepts/trigger/budget-trigger.md)