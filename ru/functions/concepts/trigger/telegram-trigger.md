# Триггер для Telegram, который вызывает функцию {{ sf-name }}

[Триггер](../trigger/) для Telegram вызывает [функцию](../function.md) {{ sf-name }}, когда Telegram-бот получает новое обновление: сообщение, команду, срабатывание кнопки и другие события. Для получения обновлений триггер использует токен Telegram-бота.

Триггеру для Telegram необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова функции.

О том, как создать триггер для Telegram, читайте в инструкции [{#T}](../../operations/trigger/telegram-trigger-create.md).

{% include [batching-messages](../../../_includes/functions/batching-messages.md) %}

## Роли, необходимые для корректной работы триггера для Telegram {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `{{ roles-functions-invoker }}` на функцию, которую вызывает триггер.

## Формат сообщения от триггера для Telegram {#format}

После того как триггер сработает, он отправит в функцию объект [Update](https://core.telegram.org/bots/api#update) из Telegram Bot API.

## Полезные ссылки {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/telegram-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/telegram-trigger.md)
