# Таймер, который вызывает функцию {{ sf-name }}

_Таймер_ — это [триггер](../trigger/), который запускает [функцию](../function.md) {{ sf-name }} по расписанию. Расписание задается в виде [cron-выражения](#cron-expression). Время в cron-выражении указывается по [UTC+0](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

Таймеру необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова функции.

О том, как создать таймер, читайте в инструкции [{#T}](../../operations/trigger/timer-create.md).

{% include [cron-expression](../../../_includes/functions/cron-expression.md) %}

## Роли, необходимые для корректной работы таймера {#roles}

* Для создания таймера вам необходимо разрешение на сервисный аккаунт, от имени которого таймер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
* Для работы таймера сервисному аккаунту необходима роль `{{ roles-functions-invoker }}` на каталог с функцией, которую вызывает таймер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от таймера {#format}

После того как триггер сработает, он отправит в функцию следующее сообщение:

{% include [timer-format](../../../_includes/functions/timer-format.md) %}

## См. также {#see-also}

* [Таймер для запуска контейнера {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/timer.md).
