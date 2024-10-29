# Триггер для {{ yds-name }}, который вызывает контейнер {{ serverless-containers-name }}

 [Триггер](../trigger/) для {{ yds-name }} запускает [контейнер](../container.md) {{ serverless-containers-name }} при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts). 

Триггеру для {{ yds-name }} необходимы [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для управления потоком и вызова контейнера. Вы можете использовать один и тот же сервисный аккаунт для обеих операций. 

О том, как создать триггер для {{ yds-name }}, читайте в инструкции [{#T}](../../operations/data-streams-trigger-create.md).

## Роли, необходимые для корректной работы триггера для {{ yds-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисным аккаунтам необходимы роли:
    * `serverless.containers.invoker` на контейнер, который вызывает триггер.
    * `yds.admin` на поток, при отправке данных в который вызывается триггер.

## Формат сообщения от триггера для {{ yds-name }} {#format}

После того как триггер сработает, он отправит в контейнер сообщение. Формат сообщения зависит от источника и представляет собой массив `messages`:

{% include [yds-format](../../../_includes/functions/yds-format.md) %}


## См. также {#see-also}

* [{#T}](../../../functions/concepts/trigger/data-streams-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/data-streams-trigger.md)
