1. {% include [cli-install](../cli-install.md) %}

1. Назначьте [роль](../../iam/concepts/access-control/roles.md) для группы:

    ```bash
    yc organization-manager organization add-access-binding \
    --subject=group:<идентификатор_группы> \
    --role=<идентификатор_роли> \
    <идентификатор_организации>
    ```

1. Проверьте, что запрошенные права были выданы:

    ```bash
    yc organization-manager organization list-access-bindings <идентификатор_организации>
    ```

    Ответ содержит список всех ролей, выданных пользователям и группам в организации:

    ```
    +------------------------------------------+--------------+----------------------+
    |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
    +------------------------------------------+--------------+----------------------+
    | organization-manager.admin               | userAccount  | ajev1p2345lj67u89adi |
    | organization-manager.organizations.owner | userAccount  | ajev1p2345lj67u89adi |
    | editor                                   | group        | ajeq123cmuotesu4e567 |
    | viewer                                   | group        | ajeq123cmuotesu4e567 |
    +------------------------------------------+--------------+----------------------+
    ```