# Посмотреть роли, назначенные на контейнер

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

- API

  Посмотреть роли, назначенные на контейнер, можно с помощью метода API [listAccessBindings](../../serverless-containers/containers/api-ref/Container/listAccessBindings.md).

{% endlist %}

{% note info %}

[Роли](../security/index.md#roles), назначенные на каталог или облако, автоматически [наследуются](../../iam/concepts/access-control/index.md#inheritance) контейнером. При этом они не отображаются в списке ролей, назначенных на него. Подробнее о [просмотре ролей](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}
