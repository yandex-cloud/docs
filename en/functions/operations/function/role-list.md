---
title: How to view roles assigned for a function
description: Follow this guide to view roles assigned for a function.
---

# Viewing roles assigned for a function

{% note info %}

A function automatically [inherits](../../../iam/concepts/access-control/index.md#inheritance) [roles](../../security/index.md#roles-list) assigned for a folder, cloud, or organization. However, they are not displayed in the list of assigned roles. You can learn more about viewing roles [here](../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To view [roles](../../security/index.md#roles-list) assigned for a function, run this command:
    
    ```bash
    yc serverless function list-access-bindings <function_name>
    ```

    Result:
    ```text
    +------------------------------+--------------+-----------------------+
    |           ROLE ID            | SUBJECT TYPE |       SUBJECT ID      |
    +------------------------------+--------------+-----------------------+
    | {{ roles-functions-invoker }}    | system       | allAuthenticatedUsers |
    +------------------------------+--------------+-----------------------+
    ```

- API {#api}

  To view roles for a function, use the [listAccessBindings](../../functions/api-ref/Function/listAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/ListAccessBindings](../../functions/api-ref/grpc/Function/listAccessBindings.md) gRPC API call.

{% endlist %}
