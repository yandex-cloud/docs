# Таймер, который отправляет сообщения в WebSocket-соединения

_Таймер_ — это [триггер](../trigger/), который отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md) по расписанию. Расписание задается в виде [cron-выражения](#cron-expression). Время в cron-выражении указывается по [UTC+0](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

Таймеру необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для отправки сообщений в WebSocket-соединения.

О том, как создать таймер, читайте в инструкции [{#T}](../../operations/trigger/timer-create.md).

{% include [cron-expression](../../../_includes/functions/cron-expression.md) %}

## Роли, необходимые для корректной работы таймера {#roles}

* Для создания таймера вам необходимо разрешение на сервисный аккаунт, от имени которого таймер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
* Для работы таймера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от таймера {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

{% include [timer-format](../../../_includes/functions/timer-format.md) %}

## См. также {#see-also}

* [Таймер для запуска контейнера {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/timer.md)
* [Таймер для запуска функции {{ sf-name }}](../../../functions/concepts/trigger/timer.md)
