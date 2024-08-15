# Сделать функцию приватной

Чтобы функцию могли вызвать только пользователи, у которых есть права на ее вызов, сделайте функцию приватной.

{% note info %}

Если на облако или каталог всем неавторизованным пользователям ([публичная группа](../../../iam/concepts/access-control/public-group.md) `All users`) выданы права на вызов функции, функция будет публичной вне зависимости от ее настроек. [Как отозвать роль](../../../iam/operations/roles/revoke.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию, которую хотите сделать приватной.
    1. На странице **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** отключите опцию **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.
    
- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы сделать функцию приватной, выполните команду:

    ```
    yc serverless function deny-unauthenticated-invoke <имя_функции>
    ```

    Результат:
    ```
    done (1s)   
    ```

{% endlist %}
