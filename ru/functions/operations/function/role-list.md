---
title: "Как посмотреть роли, назначенные на функцию"
description: "Следуя данной инструкции, вы сможете посмотреть роли, назначенные на функцию."
---

# Посмотреть роли, назначенные на функцию

{% note info %}

[Роли](../../security/index.md#roles-list), назначенные на каталог или облако, автоматически [наследуются](../../../iam/concepts/access-control/index.md#inheritance) функцией. При этом они не отображаются в списке ролей, назначенных на нее. Подробнее о [просмотре ролей](../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы посмотреть [роли](../../security/index.md#roles-list), назначенные на функцию, выполните команду:
    
    ```
    yc serverless function list-access-bindings <имя_функции>
    ```

    Результат:
    ```
    +------------------------------+--------------+-----------------------+
    |           ROLE ID            | SUBJECT TYPE |       SUBJECT ID      |
    +------------------------------+--------------+-----------------------+
    | {{ roles-functions-invoker }}    | system       | allAuthenticatedUsers |
    +------------------------------+--------------+-----------------------+
    ```

- API {#api}

  Чтобы посмотреть роли на функцию, воспользуйтесь методом REST API [listAccessBindings](../../functions/api-ref/Function/listAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/ListAccessBindings](../../functions/api-ref/grpc/function_service.md#ListAccessBindings).

{% endlist %}
