---
title: "Отозвать роли, назначенные на контейнер"
description: "Следуя данной инструкции, вы сможете отозвать роли, назначенные на контейнер."
---

# Отозвать роли, назначенные на контейнер

{% list tabs %}

- CLI

  Выполните команду, чтобы отозвать [роль](../security/index.md) на контейнер:

    * у пользователя:
        ```
        yc serverless container remove-access-binding \
          --name <имя_контейнера> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * у [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):
        ```
        yc serverless container remove-access-binding \
          --name <имя_контейнера> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * у всех авторизованных пользователей (системная группа `allAuthenticatedUsers`):
        ```
        yc serverless container remove-access-binding \
          --name <имя_контейнера> \
          --all-authenticated-users \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```

- API

  Чтобы отозвать роли, назначенные на контейнер, воспользуйтесь методом REST API [updateAccessBindings](../containers/api-ref/Container/updateAccessBindings.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/UpdateAccessBindings](../containers/api-ref/grpc/container_service.md#UpdateAccessBindings).

{% endlist %}