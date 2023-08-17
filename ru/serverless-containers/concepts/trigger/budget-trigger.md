# Триггер для бюджетов, который вызывает контейнер {{ serverless-containers-name }}

[Триггер](../trigger/) для [бюджетов](../../../billing/concepts/budget.md) запускает [контейнер](../container.md) {{ serverless-containers-name }} при превышении пороговых значений.

Триггеру для бюджетов необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова контейнера.

О том, как создать триггер для бюджетов, читайте в инструкции [{#T}](../../operations/budget-trigger-create.md).

## Роли, необходимые для корректной работы триггера для бюджетов {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `serverless.containers.invoker` на контейнер, который вызывает триггер.

## Формат сообщения от триггера для бюджетов {#format}

После того, как триггер сработает, он отправит в контейнер следующее сообщение:

{% include [budget-format](../../../_includes/functions/budget-format.md) %}

## См. также {#see-also}

* [Триггер для бюджетов, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/budget-trigger.md).