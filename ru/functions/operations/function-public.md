# Управление правами доступа к функции

Вы можете сделать функцию [публичной](#public) или [приватной](#private), [посмотреть](#list), какие роли на нее назначены, [отозвать](#revoke) их или [назначить](#add-access) новые.

## Сделать функцию публичной {#public}

Чтобы любой пользователь мог вызвать функцию без передачи заголовка авторизации, сделайте ее публичной.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию, которую хотите сделать публичной.
    1. На странице **Обзор**, в разделе **Общая информация**, переведите переключатель **Публичная функция** в активное состояние.
    
- CLI 

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы сделать функцию публичной, выполните команду:
    
    ```
    yc serverless function allow-unauthenticated-invoke <имя функции>
    ```

    Результат:

    ```
    done (1s)    
    ```

- API

    Сделать функцию публичной можно с помощью метода API [setAccessBindings](../functions/api-ref/Function/setAccessBindings.md).

{% endlist %}

## Сделать функцию приватной {#private}

Чтобы функцию могли вызвать только пользователи, у которых есть права на ее вызов, сделайте функцию приватной.

{% note info %}

Если на облако или каталог всем неавторизованным пользователям (системная группа `allUsers`) выданы права на вызов функции, функция будет публичной вне зависимости от ее настроек. [Как отозвать роль.](../../iam/operations/roles/revoke.md)

{% endnote %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию, которую хотите сделать приватной.
    1. На странице **Обзор**, в разделе **Общая функция**, переведите переключатель **Публичная функция** в неактивное состояние.
    
- CLI 

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы сделать функцию приватной, выполните команду:

    ```
    yc serverless function deny-unauthenticated-invoke <имя функции>
    ```

    Результат:
    ```
    done (1s)   
    ```

{% endlist %}

## Посмотреть роли, назначенные на функцию {#list}

{% list tabs %}
    
- CLI 

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть [роли](../security/index.md#roles), назначенные на функцию, выполните команду:
    
    ```
    yc serverless function list-access-bindings <имя функции>
    ```

    Результат:
    ```
    +------------------------------+--------------+-----------------------+
    |           ROLE ID            | SUBJECT TYPE |       SUBJECT ID      |
    +------------------------------+--------------+-----------------------+
    | serverless.functions.invoker | system       | allAuthenticatedUsers |
    +------------------------------+--------------+-----------------------+
    ```

- API

    Посмотреть [роли](../security/index.md#roles), назначенные на функцию, можно с помощью метода API [listAccessBindings](../../functions/api-ref/Function/listAccessBindings.md).

{% endlist %}

{% note info %}

[Роли](../security/index.md#roles), назначенные на каталог или облако, автоматически [наследуются](../../iam/concepts/access-control/index.md#inheritance) функцией. При этом они не отображаются в списке ролей, назначенных на нее. Подробнее о [просмотре ролей](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

## Назначить роли на функцию {#add-access}

{% list tabs %}
    
- CLI 

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Выполните команду, чтобы назначить [роль](../security/index.md#roles) на функцию:

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
    * [сервисному аккаунту](../../iam/concepts/users/service-accounts.md):  
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

    Назначить роли на функцию можно с помощью метода API [setAccessBindings](../functions/api-ref/Function/setAccessBindings.md).

{% endlist %}

## Отозвать роли, назначенные на функцию {#revoke}

{% list tabs %}
    
- CLI 

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Выполните команду, чтобы отозвать [роль](../security/index.md#roles) на функцию:

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
    * у [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):
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

    Отозвать роли на функцию можно с помощью метода API [updateAccessBindings](../functions/api-ref/Function/updateAccessBindings.md).

{% endlist %}
