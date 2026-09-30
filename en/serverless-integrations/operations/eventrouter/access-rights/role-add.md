---
title: How to assign roles for a {{ er-full-name }} resource
description: Follow this tutorial to assign roles for an {{ er-name }} resource.
---

# Assigning roles for an {{ er-name }} resource

{% include [sunset-note](../../../../_includes/serverless-integrations/sunset-note.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To assign a role for an {{ er-name }} resource, run the following command:

  ```bash
  yc serverless <resource_type> add-access-binding <resource_name_or_ID> \
    --role <role> \
    --subject <subject_type>:<subject_ID>
  ```

  Where:

  * `--role`: [Role](../../../security/index.md#roles-list).
  * `--subject`: [Subject](../../../../iam/concepts/access-control/index.md#subject) getting the role.

      {% cut "Subject designations" %}

      {% include [subjects-designations-cli](../../../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}

  **Example**

  Assigning a role to a service account for a [bus](../../../concepts/eventrouter/bus.md):

  ```bash
  yc serverless eventrouter bus add-access-binding epdplu8jn7sr******** \
    --service-account-id rrbilgiqaptv******** \
    --role serverless.eventrouter.auditor
  ```

  Result:

  ```text
  ...1s...done (3s)
  ```

- API {#api}

  Use the `setAccessBinding` REST API method for the appropriate resource or this gRPC API call: `<service>/SetAccessBinding`.

  For example, when assigning roles for a [bus](../../../concepts/eventrouter/bus.md), use the [setAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/Bus/setAccessBindings.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [BusService/SetAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/setAccessBindings.md) gRPC API call. In the request body, set the `action` property to `ADD` and specify [subject](../../../../iam/concepts/access-control/index.md#subject) type and ID in the `subject` property.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}