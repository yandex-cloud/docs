# Триггер для {{ objstorage-name }}

[Триггер](../trigger/) для {{ objstorage-name }} запускает [контейнер](../container.md) {{ serverless-containers-name }}, когда наступает определенное событие с [объектом](../../../storage/concepts/object.md) {{ objstorage-full-name }}. Триггер должен находиться в одном облаке с бакетом, на события которого он подписан.

Триггеру для {{ objstorage-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова контейнера.

{% include [os-event](../../../_includes/functions/os-event.md) %}

## Роли, необходимые для корректной работы триггера для {{ objstorage-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `serverless.containers.invoker` на каталог с контейнером, который вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ objstorage-name }} {#format}

После того как триггер сработает, он отправит в контейнер следующее сообщение: 

{% include [os-format](../../../_includes/functions/os-format.md) %}

## См. также {#see-also_}

* [Триггер для {{ objstorage-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/os-trigger.md).