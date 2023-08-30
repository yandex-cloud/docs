# Отозвать роли, назначенные на функцию

{% list tabs %}
    
- CLI 

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Выполните команду, чтобы отозвать [роль](../../security/index.md#roles-list) на функцию:

    * у пользователя:
        ```
        yc serverless function remove-access-binding \
          --id <идентификатор функции> \
          --user-account-id <идентификатор пользователя> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * у [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md):
        ```
        yc serverless function remove-access-binding \
          --id <идентификатор функции> \
          --service-account-id <идентификатор сервисного аккаунта> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * у всех авторизованных пользователей (системная группа `allAuthenticatedUsers`):
        ```
        yc serverless function remove-access-binding \
          --id <идентификатор функции> \
          --all-authenticated-users \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```

- API

  Чтобы отозвать роли на функцию, воспользуйтесь методом REST API [updateAccessBindings](../../functions/api-ref/Function/updateAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/UpdateAccessBindings](../../functions/api-ref/grpc/function_service.md#UpdateAccessBindings).

{% endlist %}