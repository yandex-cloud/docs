---
title: Назначить роли на функцию
description: Следуя данной инструкции, вы сможете назначить роли на функцию.
---

# Назначить роли на функцию

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Выполните команду, чтобы назначить [роль](../../security/index.md#roles-list) на функцию:

    * пользователю:
        ```
        yc serverless function add-access-binding \
          --id <идентификатор_функции> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md):  
        ```
        yc serverless function add-access-binding \
          --id <идентификатор_функции> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * всем авторизованным пользователям ([публичная группа](../../../iam/concepts/access-control/public-group.md) `All authenticated users`):
        ```
        yc serverless function add-access-binding \
          --id <идентификатор_функции> \
          --all-authenticated-users \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```

- API {#api}

  Чтобы назначить роли на функцию, воспользуйтесь методом REST API [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/SetAccessBindings](../../functions/api-ref/grpc/Function/setAccessBindings.md).

{% endlist %}