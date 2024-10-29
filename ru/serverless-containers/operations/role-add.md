---
title: Назначить роли на контейнер
description: Следуя данной инструкции, вы сможете назначить роли на контейнер.
---

# Назначить роли на контейнер

{% list tabs group=instructions %}

- CLI {#cli}

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
    * всем авторизованным пользователям ([публичная группа](../../iam/concepts/access-control/public-group.md) `All authenticated users`):
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

- API {#api}

  Чтобы назначить роли на контейнер, воспользуйтесь методом REST API [setAccessBindings](../containers/api-ref/Container/setAccessBindings.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/SetAccessBindings](../containers/api-ref/grpc/Container/setAccessBindings.md).

{% endlist %}