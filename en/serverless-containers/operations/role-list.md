---
title: How to view roles assigned to a container
description: Use this guide to view roles assigned to a container.
---

# Viewing roles assigned to a container

{% note info %}

A container automatically [inherits](../security/index.md#roles-list) [roles](../../iam/concepts/access-control/index.md#inheritance) assigned for a folder, cloud, or organization. However, they do not appear in the list of assigned roles. You can learn more about viewing roles [here](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    To view [container](../concepts/container.md) roles, run this command:

    ```bash
    yc serverless container list-access-bindings --name=<container_name>
    ```

    Result:

    ```text
    +---------+--------------+-----------------------+
    | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
    +---------+--------------+-----------------------+
    | editor  | system       | allAuthenticatedUsers |
    +---------+--------------+-----------------------+
    ```

- API {#api}

  To view container roles, use the [listAccessBindings](../containers/api-ref/Container/listAccessBindings.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/ListAccessBindings](../containers/api-ref/grpc/container_service.md#ListAccessBindings) gRPC API call.

{% endlist %}
