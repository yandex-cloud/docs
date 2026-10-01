---
title: Revoking roles assigned for a function
description: Follow this guide to revoke roles assigned for a function.
---

# Revoking roles assigned for a function

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To revoke a [role](../../security/index.md#roles-list) for a function, run this command:

    ```bash
    yc serverless function remove-access-binding \
      --id <function_ID> \
      --role <role_ID> \
      --subject <subject_type>:<subject_ID>
    ```

    Where:

    * `--role`: ID of the role you need to revoke.
    * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) to revoke the role from.

        {% cut "Subject designations" %}

        {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

        {% endcut %}

- API {#api}

  To revoke roles for a function, use the [updateAccessBindings](../../functions/api-ref/Function/updateAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/UpdateAccessBindings](../../functions/api-ref/grpc/Function/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the [subject](../../../iam/concepts/access-control/index.md#subject) type and ID under `subject`.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}
