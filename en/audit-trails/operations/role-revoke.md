---
title: Revoking roles assigned for a trail
description: Use this guide to revoke roles assigned for a trail.
---

# Revoking roles assigned for a trail

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to revoke [roles](../security/index.md#roles-list) assigned for a [trail](../concepts/trail.md):

      ```bash
      yc audit-trails trail remove-access-binding --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}
  1. To revoke a role assigned for a trail, run this command:

      ```bash
      yc audit-trails trail remove-access-binding \
        --id <trail_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

     Where:

     * `--role`: ID of the role you need to revoke.
     * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) to revoke the role from.

         {% cut "Subject designations" %}

         {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

         {% endcut %}

- API {#api}

  To revoke roles for a [trail](../concepts/trail.md), use the [updateAccessBindings](../../audit-trails/api-ref/Trail/updateAccessBindings.md) REST API method for the [Trail](../../audit-trails/api-ref/Trail/index.md) resource or the [TrailService/UpdateAccessBindings](../../audit-trails/api-ref/grpc/Trail/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the [subject](../../iam/concepts/access-control/index.md#subject) type and ID under `subject`.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}
