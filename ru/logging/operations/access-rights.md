# Управление правами доступа к лог-группе

Вы можете посмотреть, какие роли [назначены](#list) на лог-группу, [отозвать](#revoke) их или [назначить](#add-access) новые.

{% note info %}

[Лог-группа по умолчанию](../concepts/log-group.md) наследует [роли, назначенные на каталог](../../iam/operations/roles/get-assigned-roles.md), в котором она находится. Чтобы изменить права доступа к ней, [назначьте](../../iam/operations/roles/grant.md) или [отзовите](../../iam/operations/roles/revoke.md) роли на каталог.

{% endnote %}

## Посмотреть роли, назначенные на лог-группу {#list}

{% list tabs group=instructions %}

- CLI {#cli}

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

- API {#api}

  Чтобы посмотреть роли, назначенные на пользовательскую лог-группу, воспользуйтесь методом REST API [listAccessBindings](../api-ref/LogGroup/listAccessBindings.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/ListAccessBindings](../api-ref/grpc/LogGroup/listAccessBindings.md).

{% endlist %}

## Назначить роли на лог-группу {#add-access}

{% list tabs group=instructions %}

- CLI {#cli}

    Выполните команду, чтобы назначить [роль](../security/index.md) на пользовательскую лог-группу:

    ```bash
    yc logging group add-access-binding \
      --name <имя_лог-группы> \
      --role <роль> \
      --subject <тип_субъекта>:<идентификатор_субъекта>
    ```

    Где:

    * `--role` — назначаемая [роль](../security/index.md#roles-list).
    * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

        {% cut "Обозначения субъектов" %}

        {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

        {% endcut %}

- API {#api}

  Чтобы назначить роли на пользовательскую лог-группу, воспользуйтесь методом REST API [setAccessBindings](../api-ref/LogGroup/setAccessBindings.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/SetAccessBindings](../api-ref/grpc/LogGroup/setAccessBindings.md).

{% endlist %}

## Отозвать роли, назначенные на лог-группу {#revoke}

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы отозвать [роль](../security/index.md) на пользовательскую лог-группу:

  ```bash
  yc logging group remove-access-binding \
    --name <имя_лог-группы> \
    --role <идентификатор_роли> \
    --subject <тип_субъекта>:<идентификатор_субъекта>
  ```

  Где:

  * `--role` — идентификатор роли, которую надо отозвать.
  * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}

- API {#api}

  Чтобы отозвать роли, назначенные на пользовательскую лог-группу, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/LogGroup/updateAccessBindings.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/UpdateAccessBindings](../api-ref/grpc/LogGroup/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}
