# Триггер для почты, который вызывает функцию {{ sf-name }}

[Триггер](../trigger/) для почты запускает [функцию](../function.md) {{ sf-name }}, когда на электронную почту приходит письмо. Адрес электронной почты генерируется сервисом автоматически во время создания триггера.

Триггеру для почты необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова функции.

О том, как создать триггер для почты, читайте в инструкции [{#T}](../../operations/trigger/mail-trigger-create.md).

{% include [batching-messages](../../../_includes/functions/batching-messages.md) %}

## Роли, необходимые для корректной работы триггера для почты {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [{{ roles-editor }}](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `{{ roles-functions-invoker }}` на функцию, которую вызывает триггер.
* {% include [attachments-requirements](../../../_includes/functions/attachments-requirements.md) %}

## Формат сообщения от триггера для почты {#format}

После того как триггер сработает, он отправит в функцию следующее сообщение:

{% include [mail-format](../../../_includes/functions/mail-format.md) %}

## См. также {#see-also}

* [Триггер для почты, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/mail-trigger.md).
