# Управление правами доступа к контейнеру

Вы можете сделать контейнер [публичным](#public) или [приватным](#private), посмотреть, какие роли [назначены](#list) на него, [отозвать](#revoke) их или [назначить](#add-access) новые.

## Сделать контейнер публичным {#public}

Чтобы любой пользователь мог вызвать контейнер без передачи заголовка авторизации, сделайте контейнер публичным.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы сделать контейнер публичным, выполните команду:

    ```
    yc serverless container allow-unauthenticated-invoke <имя_контейнера>
    ```

    Результат:

    ```
    done (1s)
    ```

{% endlist %}

## Сделать контейнер приватным {#private}

Чтобы контейнер могли вызвать только пользователи, у которых есть права на его вызов, сделайте контейнер приватным.

{% note info %}

Если на облако или каталог всем неавторизованным пользователям (системная группа `allUsers`) выданы права на вызов контейнера, контейнер будет публичным вне зависимости от его настроек. [Как отозвать роль.](../../iam/operations/roles/revoke.md)

{% endnote %}

{% list tabs %}

- CLI

    Чтобы сделать контейнер приватным, выполните команду:

    ```
    yc serverless container deny-unauthenticated-invoke <имя_контейнера>
    ```

    Результат:

    ```
    done (1s)
    ```

{% endlist %}

## Посмотреть роли, назначенные на контейнер {#list}

{% list tabs %}

- CLI

    Чтобы посмотреть [роли](../security/index.md), назначенные на [контейнер](../concepts/container.md), выполните команду:

    ```
    yc serverless container list-access-bindings --name=<имя_контейнера>
    ```

    Результат:

    ```
    +---------+--------------+-----------------------+
    | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
    +---------+--------------+-----------------------+
    | editor  | system       | allAuthenticatedUsers |
    +---------+--------------+-----------------------+
    ```

{% endlist %}

{% note info %}

[Роли](../security/index.md#roles), назначенные на каталог или облако, автоматически [наследуются](../../iam/concepts/access-control/index.md#inheritance) контейнером. При этом они не отображаются в списке ролей, назначенных на него. Подробнее о [просмотре ролей](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

## Назначить роли на контейнер {#add-access}

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

{% endlist %}

## Отозвать роли, назначенные на контейнер {#revoke}

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

{% endlist %}