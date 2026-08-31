---
title: Назначить роли на функцию
description: Следуя данной инструкции, вы сможете назначить роли на функцию.
---

# Назначить роли на функцию

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Выполните команду, чтобы назначить [роль](../../security/index.md#roles-list) на функцию:

    ```bash
    yc serverless function add-access-binding \
      --id <идентификатор_функции> \
      --role <роль> \
      --subject <тип_субъекта>:<идентификатор_субъекта>
    ```

    Где:

    * `--role` — назначаемая [роль](../../security/index.md#roles-list).
    * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

        {% cut "Обозначения субъектов" %}

        {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

        {% endcut %}

- API {#api}

  Чтобы назначить роли на функцию, воспользуйтесь методом REST API [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/SetAccessBindings](../../functions/api-ref/grpc/Function/setAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}