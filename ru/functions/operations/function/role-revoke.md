---
title: Отозвать роли, назначенные на функцию
description: Следуя данной инструкции, вы сможете отозвать роли, назначенные на функцию.
---

# Отозвать роли, назначенные на функцию

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Выполните команду, чтобы отозвать [роль](../../security/index.md#roles-list) на функцию:

    * у пользователя:
        ```
        yc serverless function remove-access-binding \
          --id <идентификатор_функции> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * у [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md):
        ```
        yc serverless function remove-access-binding \
          --id <идентификатор_функции> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * у всех авторизованных пользователей ([публичная группа](../../../iam/concepts/access-control/public-group.md) `All authenticated users`):
        ```
        yc serverless function remove-access-binding \
          --id <идентификатор_функции> \
          --all-authenticated-users \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```

- API {#api}

  Чтобы отозвать роли на функцию, воспользуйтесь методом REST API [updateAccessBindings](../../functions/api-ref/Function/updateAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/UpdateAccessBindings](../../functions/api-ref/grpc/function_service.md#UpdateAccessBindings).

{% endlist %}