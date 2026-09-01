[Документация Yandex Cloud](../../../index.md) > [Yandex API Gateway](../../index.md) > [Концепции](../index.md) > [Триггер](index.md) > Триггер для Telegram

# Триггер для Telegram, который отправляет сообщения в WebSocket-соединения

[Триггер](index.md) для Telegram отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md), когда Telegram-бот получает обновление: сообщение, команду, срабатывание кнопки и другие события. Для получения обновлений триггер использует токен Telegram-бота.

Триггеру для Telegram необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для отправки сообщений в WebSocket-соединения.

О том, как создать триггер для Telegram, читайте в инструкции [Создать триггер для Telegram, который отправляет сообщения в WebSocket-соединения](../../operations/trigger/telegram-trigger-create.md).

## Роли, необходимые для корректной работы триггера для Telegram {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

## Формат сообщения от триггера для Telegram {#format}

После того как триггер сработает, он отправит в WebSocket-соединения объект [Update](https://core.telegram.org/bots/api#update) из Telegram Bot API.

## Полезные ссылки {#see-also}

* [Триггер для Telegram, который запускает контейнер Serverless Containers](../../../serverless-containers/concepts/trigger/telegram-trigger.md)
* [Триггер для Telegram, который запускает функцию Cloud Functions](../../../functions/concepts/trigger/telegram-trigger.md)