# Триггер для бюджетов, который вызывает функцию {{ sf-name }}

[Триггер](../trigger/) для [бюджетов](../../../billing/concepts/budget.md) запускает [функцию](../function.md) {{ sf-name }} при превышении пороговых значений.

Триггеру для бюджетов необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова функции.

## Роли, необходимые для корректной работы триггера для бюджетов {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `serverless.functions.invoker` на функцию, которую вызывает триггер.

## Формат сообщения от триггера для бюджетов {#format}

После того как триггер сработает, он отправит в функцию следующее сообщение:

{% include [budget-format](../../../_includes/functions/budget-format.md) %}

## См. также {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/budget-trigger.md).
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md).