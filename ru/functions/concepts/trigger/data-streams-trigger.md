# Триггер для {{ yds-name }}

 [Триггер](../trigger/) для {{ yds-name }} запускает [функцию](../function.md) {{ sf-name }} при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts). 

Триггеру для {{ yds-name }} необходимы [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для управления потоком и вызова функции. Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

## Роли, необходимые для корректной работы триггера для {{ yds-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисным аккаунтам необходимы роли:
    * `serverless.functions.invoker` на функцию, которую вызывает триггер;
    * `yds.admin` на поток, при отправке данных в который вызывается триггер.

## Формат сообщения от триггера для {{ yds-name }} {#format}

После того как триггер сработает, он отправит в функцию сообщение. Формат сообщения зависит от источника и представляет собой массив `messages`:

{% include [yds-format](../../../_includes/functions/yds-format.md) %}

## См. также {#see-also}

* [Триггер для {{ yds-name }}, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/data-streams-trigger.md).