---
title: How to view roles assigned for a {{ er-full-name }} resource
description: Follow this guide to view roles assigned for an {{ er-name }} resource.
---

# Viewing roles assigned for an {{ er-name }} resource

{% note info %}

An {{ er-name }} resource automatically [inherits](../../../../iam/concepts/access-control/index.md#inheritance) roles assigned for a folder, cloud, or organization. However, they are not displayed in the list of assigned roles. You can learn more about viewing roles [here](../../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To view roles assigned for an {{ er-name }} resource, run this command:

  ```bash
  yc serverless <resource_type> list-access-bindings <resource_name_or_ID>
  ```

  **Example**

  Viewing roles assigned for a [bus](../../../concepts/eventrouter/bus.md):

  ```bash
  yc serverless eventrouter bus list-access-bindings epdplu8jn7sr********
  ```

  Result:

  ```text
  +---------------------------------+----------------+----------------------+
  |             ROLE ID             |  SUBJECT TYPE  |      SUBJECT ID      |
  +---------------------------------+----------------+----------------------+
  | serverless.eventrouter.admin    | serviceAccount | ajef2lm8ahpc******** |
  | serverless.eventrouter.auditor  | serviceAccount | rrbilgiqaptv******** |
  +---------------------------------+----------------+----------------------+
  ```

- API {#api}

  Use the `listAccessBindings` REST API method for the relevant resource or the `<service>/ListAccessBindings` gRPC API call.

  For example, for a bus, use the [listAccessBindings](../../../../serverless-integrations/eventrouter/api-ref/Bus/listAccessBindings.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [BusService/ListAccessBindings](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/listAccessBindings.md) gRPC API call.

{% endlist %}