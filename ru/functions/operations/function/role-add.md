# Назначить роли на функцию
{% list tabs %}
    
- CLI 

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Выполните команду, чтобы назначить [роль](../../security/index.md#roles) на функцию:

    * пользователю:
        ```
        yc serverless function add-access-binding \
          --id <идентификатор функции> \
          --user-account-id <идентификатор пользователя> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md):  
        ```
        yc serverless function add-access-binding \
          --id <идентификатор функции> \
          --service-account-id <идентификатор сервисного аккаунта> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * всем авторизованным пользователям (системная группа `allAuthenticatedUsers`):
        ```
        yc serverless function add-access-binding \
          --id <идентификатор функции> \
          --all-authenticated-users \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```

- API

    Назначить роли на функцию можно с помощью метода API [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md).

{% endlist %}