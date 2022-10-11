[Триггер](../../functions/concepts/trigger/index.md) {{ sf-name }} запускает [функцию](../../functions/concepts/function.md), когда с [Docker-образом](../../container-registry/concepts/docker-image.md) {{ container-registry-name }} происходят определенные события. Триггер должен находиться в одном облаке с [реестром](../../container-registry/concepts/registry.md), на события которого он подписан.

Триггеру для {{ container-registry-name }} необходим [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для вызова функции.

{% include [cr-event](cr-event.md) %}

## Роли, необходимые для корректной работы триггера для {{ container-registry-name }} {#roles}

* Для создания триггера вам необходимы:
    * Разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../iam/concepts/access-control/roles.md#sa-user), [editor](../../iam/concepts/access-control/roles.md#editor) и выше.
    * Роль `{{ roles-cr-puller }}` на реестр, события которого триггер обрабатывает.
* Для работы триггера сервисному аккаунту необходима роль `serverless.containers.invoker` на каталог с контейнером, который вызывает триггер.

Подробнее об [управлении доступом](../../functions/security/index.md).

## Формат сообщения от триггера {{ container-registry-name }} {#format}

После того как триггер сработает, он отправит в функцию сообщение следующего вида:

{% include [cr-format](cr-format.md) %}

## См. также {#see-also}

* [Триггер для {{ container-registry-name }}, который запускает контейнер {{ serverless-containers-name }}](../../serverless-containers/concepts/trigger/cr-trigger.md).