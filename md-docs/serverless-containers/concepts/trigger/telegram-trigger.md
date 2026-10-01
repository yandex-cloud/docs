[Документация Yandex Cloud](../../../index.md) > [Yandex Serverless Containers](../../index.md) > [Концепции](../index.md) > [Триггер](index.md) > Триггер для Telegram

# Триггер для Telegram, который вызывает контейнер Serverless Containers

[Триггер](index.md) для Telegram запускает [контейнер](../container.md) Serverless Containers, когда Telegram-бот получает новое обновление: сообщение, команду, callback от кнопки и другие события. Для получения обновлений триггер использует токен Telegram-бота.

Триггеру для Telegram необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова контейнера.

О том, как создать триггер для Telegram, читайте в инструкции [Создать триггер для Telegram, который вызывает контейнер Serverless Containers](../../operations/telegram-trigger-create.md).

## Роли, необходимые для корректной работы триггера для Telegram {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `serverless-containers.containerInvoker` на контейнер, который вызывает триггер.

## Формат сообщения от триггера для Telegram {#format}

После того как триггер сработает, он отправит в контейнер объект [Update](https://core.telegram.org/bots/api#update) из Telegram Bot API.

## Полезные ссылки {#see-also}

* [Триггер для Telegram, который вызывает функцию Cloud Functions](../../../functions/concepts/trigger/telegram-trigger.md)
* [Триггер для Telegram, который отправляет сообщения в WebSocket-соединения](../../../api-gateway/concepts/trigger/telegram-trigger.md)