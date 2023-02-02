# Назначить роли на контейнер

{% list tabs %}

- CLI

  Выполните команду, чтобы назначить [роль](../security/index.md) на контейнер:

    * пользователю:
        ```
        yc serverless container add-access-binding \
          --name <имя_контейнера> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * [сервисному аккаунту](../../iam/concepts/users/service-accounts.md):  
        ```
        yc serverless container add-access-binding \
          --name <имя_контейнера> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```
    * всем авторизованным пользователям (системная группа `allAuthenticatedUsers`):
        ```
        yc serverless container add-access-binding \
          --name <имя_контейнера> \
          --all-authenticated-users \
          --role <роль>
        ```
        Результат:
        ```
        done (1s)
        ```

- API

  Назначить роли на контейнер можно с помощью метода API [setAccessBindings](../../serverless-containers/containers/api-ref/Container/setAccessBindings.md).

{% endlist %}