[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Концепции](../index.md) > [Триггер](index.md) > Триггер для Telegram

# Триггер для Telegram, который вызывает функцию Cloud Functions

[Триггер](index.md) для Telegram вызывает [функцию](../function.md) Cloud Functions, когда Telegram-бот получает новое обновление: сообщение, команду, срабатывание кнопки и другие события. Для получения обновлений триггер использует токен Telegram-бота.

Триггеру для Telegram необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова функции.

О том, как создать триггер для Telegram, читайте в инструкции [Создать триггер для Telegram, который вызывает функцию Cloud Functions](../../operations/trigger/telegram-trigger-create.md).

## Роли, необходимые для корректной работы триггера для Telegram {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `functions.functionInvoker` на функцию, которую вызывает триггер.

## Формат сообщения от триггера для Telegram {#format}

После того как триггер сработает, он отправит в функцию объект [Update](https://core.telegram.org/bots/api#update) из Telegram Bot API.

## Полезные ссылки {#see-also}

* [Триггер для Telegram, который вызывает контейнер Serverless Containers](../../../serverless-containers/concepts/trigger/telegram-trigger.md)
* [Триггер для Telegram, который отправляет сообщения в WebSocket-соединения](../../../api-gateway/concepts/trigger/telegram-trigger.md)