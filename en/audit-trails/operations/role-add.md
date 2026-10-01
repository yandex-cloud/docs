---
title: Assigning roles for a trail
description: Follow this tutorial to assign roles for a trail.
---

# Assigning roles for a trail

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for assigning [roles](../security/index.md#roles-list) for a [trail](../concepts/trail.md):

      ```bash
      yc audit-trails trail set-access-bindings --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}
  1. Run the following command to assign a role for a trail:

      ```bash
      yc audit-trails trail set-access-bindings \
        --id <trail_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: ID of the digital signature key pair.
      * Where `--access-binding` is the [role](../security/index.md#roles-list) and the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

      Provide a separate `--access-binding` parameter for each role. Here is an example:

      ```bash
      yc audit-trails trail set-access-bindings \
        --id <trail_ID> \
        --access-binding role=<role1>,subject=<subject_type>:<subject_ID> \
        --access-binding role=<role2>,subject=<subject_type>:<subject_ID> \
        --access-binding role=<role3>,subject=<subject_type>:<subject_ID>
      ```

- API {#api}

  To assign roles for a [trail](../concepts/trail.md), use the [setAccessBindings](../../audit-trails/api-ref/Trail/setAccessBindings.md) REST API method for the [Trail](../../audit-trails/api-ref/Trail/index.md) resource or the [TrailService/SetAccessBindings](../../audit-trails/api-ref/grpc/Trail/setAccessBindings.md) gRPC API call. In your request, provide an array of objects, each one matching a particular role and containing the following data:

   * Role in the `access_bindings[].role_id` parameter.
   * ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the roles in the `access_bindings[].subject.id` parameter.
   * Type of the subject getting the roles in the `access_bindings[].subject.type` parameter.

       {% cut "Subject designations" %}

       {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

       {% endcut %}

{% endlist %}
