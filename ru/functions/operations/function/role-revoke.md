---
title: Отозвать роли, назначенные на функцию
description: Следуя данной инструкции, вы сможете отозвать роли, назначенные на функцию.
---

# Отозвать роли, назначенные на функцию

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Выполните команду, чтобы отозвать [роль](../../security/index.md#roles-list) на функцию:

    ```bash
    yc serverless function remove-access-binding \
      --id <идентификатор_функции> \
      --role <идентификатор_роли> \
      --subject <тип_субъекта>:<идентификатор_субъекта>
    ```

    Где:

    * `--role` — идентификатор роли, которую надо отозвать.
    * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

        {% cut "Обозначения субъектов" %}

        {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

        {% endcut %}

- API {#api}

  Чтобы отозвать роли на функцию, воспользуйтесь методом REST API [updateAccessBindings](../../functions/api-ref/Function/updateAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/UpdateAccessBindings](../../functions/api-ref/grpc/Function/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}
