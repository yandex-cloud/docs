# Посмотреть роли, назначенные на функцию

{% list tabs %}
    
- CLI 

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы посмотреть [роли](../../security/index.md#roles), назначенные на функцию, выполните команду:
    
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

    Посмотреть [роли](../../security/index.md#roles), назначенные на функцию, можно с помощью метода API [listAccessBindings](../../functions/api-ref/Function/listAccessBindings.md).

{% endlist %}

{% note info %}

[Роли](../../security/index.md#roles), назначенные на каталог или облако, автоматически [наследуются](../../../iam/concepts/access-control/index.md#inheritance) функцией. При этом они не отображаются в списке ролей, назначенных на нее. Подробнее о [просмотре ролей](../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}
