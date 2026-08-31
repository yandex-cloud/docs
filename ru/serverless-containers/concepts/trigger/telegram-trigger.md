# Триггер для Telegram, который вызывает контейнер {{ serverless-containers-name }}

[Триггер](../trigger/) для Telegram запускает [контейнер](../container.md) {{ serverless-containers-name }}, когда Telegram-бот получает новое обновление: сообщение, команду, callback от кнопки и другие события. Для получения обновлений триггер использует токен Telegram-бота.

Триггеру для Telegram необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова контейнера.

О том, как создать триггер для Telegram, читайте в инструкции [{#T}](../../operations/telegram-trigger-create.md).

{% include [batching-messages](../../../_includes/serverless-containers/batching-messages.md) %}

## Роли, необходимые для корректной работы триггера для Telegram {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `{{ roles-serverless-containers-invoker }}` на контейнер, который вызывает триггер.

## Формат сообщения от триггера для Telegram {#format}

После того как триггер сработает, он отправит в контейнер объект [Update](https://core.telegram.org/bots/api#update) из Telegram Bot API.

## Полезные ссылки {#see-also}

* [{#T}](../../../functions/concepts/trigger/telegram-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/telegram-trigger.md)
