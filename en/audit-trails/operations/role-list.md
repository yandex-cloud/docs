---
title: How to view roles assigned for a trail
description: Follow this guide to view roles assigned for a trail.
---

# Viewing roles assigned for a trail

{% note info %}

A trail automatically [inherits](../../iam/concepts/access-control/index.md#inheritance) [roles](../security/index.md#roles-list) assigned for a folder, cloud, or organization. However, they do not appear in the list of assigned roles. You can learn more about viewing roles [here](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view [roles](../security/index.md#roles-list) assigned for a [trail](../concepts/trail.md):

      ```bash
      yc audit-trails trail list-access-bindings --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}
  1. View the roles assigned for a trail by specifying its name or ID:

      ```bash
      yc audit-trails trail list-access-bindings <trail_name_or_ID>
      ```

      Result:

      ```text
      +---------------------+--------------+-----------------------+
      |       ROLE ID       | SUBJECT TYPE |      SUBJECT ID       |
      +---------------------+--------------+-----------------------+
      | audit-trails.viewer | system       | allAuthenticatedUsers |
      +---------------------+--------------+-----------------------+
      ```

- API {#api}

  To view roles assigned for a [trail](../concepts/trail.md), use the [listAccessBindings](../../audit-trails/api-ref/Trail/listAccessBindings.md) REST API method for the [Trail](../../audit-trails/api-ref/Trail/index.md) resource or the [TrailService/ListAccessBindings](../../audit-trails/api-ref/grpc/Trail/listAccessBindings.md) gRPC API call.

{% endlist %}