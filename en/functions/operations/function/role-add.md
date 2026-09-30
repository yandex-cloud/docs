---
title: Assigning roles for a function
description: Follow this guide to assign roles for a function.
---

# Assigning roles for a function

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Run this command to assign a [role](../../security/index.md#roles-list) for a function:

    ```bash
    yc serverless function add-access-binding \
      --id <function_ID> \
      --role <role> \
      --subject <subject_type>:<subject_ID>
    ```

    Where:

    * `--role`: [Role](../../security/index.md#roles-list).
    * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

        {% cut "Subject designations" %}

        {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

        {% endcut %}

- API {#api}

  To assign roles for a function, use the [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/SetAccessBindings](../../functions/api-ref/grpc/Function/setAccessBindings.md) gRPC API call. In the request body, set the `action` property to `ADD` and specify the [subject](../../../iam/concepts/access-control/index.md#subject) type and ID under `subject`.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}