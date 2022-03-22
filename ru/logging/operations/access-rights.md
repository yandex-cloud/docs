# Управление правами доступа к лог-группе

Вы можете посмотреть, какие роли [назначены](#list) на лог-группу, [отозвать](#revoke) их или [назначить](#add-access) новые.

{% note info %}

[Лог-группа по умолчанию](../concepts/log-group.md) наследует [роли, назначенные на каталог](../../iam/operations/roles/get-assigned-roles.md), в котором она находится. Чтобы изменить права доступа к ней, [назначьте](../../iam/operations/roles/grant.md) или [отзовите](../../iam/operations/roles/revoke.md) роли на каталог.

{% endnote %}

## Посмотреть роли, назначенные на лог-группу {#list}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть [роли](../security/index.md), назначенные на [пользовательскую лог-группу](../concepts/log-group.md), выполните команду:

    ```
    yc logging group list-access-bindings --name=<имя_лог-группы>
    ```

    Результат:

    ```
    +---------+--------------+-----------------------+
    | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
    +---------+--------------+-----------------------+
    | editor  | system       | allAuthenticatedUsers |
    +---------+--------------+-----------------------+
    ```

- API

    Посмотреть [роли](../security/index.md#roles), назначенные на [пользовательскую лог-группу](../concepts/log-group.md), можно с помощью метода API [listAccessBindings](../api-ref/LogGroup/listAccessBindings.md).

{% endlist %}

## Назначить роли на лог-группу {#add-access}

{% list tabs %}

- CLI

    Выполните команду, чтобы назначить [роль](../security/index.md) на пользовательскую лог-группу:

    * пользователю:

        ```
        yc logging group add-access-binding \
          --name <имя_лог-группы> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```

        Результат:

        ```
        done (1s)
        ```

    * [сервисному аккаунту](../../iam/concepts/users/service-accounts.md):

        ```
        yc logging group add-access-binding \
          --name <имя_лог-группы> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```

        Результат:

        ```
        done (1s)
        ```

    * всем авторизованным пользователям (системная группа `allAuthenticatedUsers`):

        ```
        yc logging group add-access-binding \
          --name <имя_лог-группы> \
          --all-authenticated-users \
          --role <роль>
        ```

        Результат:

        ```
        done (1s)
        ```

- API

    Назначить [роли](../security/index.md#roles) на [пользовательскую лог-группу](../concepts/log-group.md) можно с помощью метода API [setAccessBindings](../api-ref/LogGroup/setAccessBindings.md).

{% endlist %}

## Отозвать роли, назначенные на лог-группу {#revoke}

{% list tabs %}

- CLI

    Выполните команду, чтобы отозвать [роль](../security/index.md) на пользовательскую лог-группу:

    * у пользователя:

        ```
        yc logging group remove-access-binding \
          --name <имя_лог-группы> \
          --user-account-id <идентификатор_пользователя> \
          --role <роль>
        ```
    
        Результат:
    
        ```
        done (1s)
        ```

    * у [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):

        ```
        yc logging group remove-access-binding \
          --name <имя_лог-группы> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --role <роль>
        ```

        Результат:

        ```
        done (1s)
        ```

    * у всех авторизованных пользователей (системная группа `allAuthenticatedUsers`):

        ```
        yc logging group remove-access-binding \
          --name <имя_лог-группы> \
          --all-authenticated-users \
          --role <роль>
        ```

        Результат:

        ```
        done (1s)
        ```

- API

    Отозвать [роли](../security/index.md#roles), назначенные на [пользовательскую лог-группу](../concepts/log-group.md), можно с помощью метода API [updateAccessBindings](../api-ref/LogGroup/updateAccessBindings.md).

{% endlist %}
