# Триггер для {{ container-registry-name }}, который вызывает контейнер {{ serverless-containers-name }}

[Триггер](../trigger/) для {{ container-registry-name }} запускает [контейнер](../container.md) {{ serverless-containers-name }}, когда с [Docker-образом](../../../container-registry/concepts/docker-image.md) {{ container-registry-name }} происходят определенные события. Триггер должен находиться в одном облаке с [реестром](../../../container-registry/concepts/registry.md), на события которого он подписан.

Триггеру для {{ container-registry-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова контейнера.

О том, как создать триггер для {{ container-registry-name }}, читайте в инструкции [{#T}](../../operations/cr-trigger-create.md).

{% include [cr-event](../../../_includes/functions/cr-event.md) %}

{% include [batching-events](../../../_includes/serverless-containers/batching-events.md) %}

## Роли, необходимые для корректной работы триггера для {{ container-registry-name }} {#roles}

* Для создания триггера вам необходимы:
    * Разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
    * Роль `{{ roles-cr-puller }}` на реестр, события которого триггер обрабатывает.
* Для работы триггера сервисному аккаунту необходима роль `serverless.containers.invoker` на каталог с контейнером, который вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ container-registry-name }} {#format}

После того как триггер сработает, он отправит в контейнер сообщение следующего вида:

{% include [cr-format](../../../_includes/functions/cr-format.md) %}

## См. также {#see-also}

* [{#T}](../../../functions/concepts/trigger/cr-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/cr-trigger.md)
