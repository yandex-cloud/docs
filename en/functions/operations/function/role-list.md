---
title: "How to view roles assigned to a function"
description: "This guide describes how you can view the roles assigned to a function."
---

# Viewing roles assigned to a function

{% note info %}

A function automatically [inherits](../../security/index.md#roles-list) [roles](../../../iam/concepts/access-control/index.md#inheritance) assigned for a folder, cloud, or organization. However, they do not appear in the list of assigned roles. You can learn more about viewing roles [here](../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To view [roles](../../security/index.md#roles-list) assigned to a function, run this command:
    
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

  To view function roles, use the [listAccessBindings](../../functions/api-ref/Function/listAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/ListAccessBindings](../../functions/api-ref/grpc/function_service.md#ListAccessBindings) gRPC API call.

{% endlist %}
