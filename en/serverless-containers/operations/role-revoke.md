---
title: Revoking roles assigned for a container
description: Follow this guide to revoke roles assigned for a container.
---

# Revoking roles assigned for a container

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command to revoke a [role](../security/index.md) for a container:

  ```bash
  yc serverless container remove-access-binding \
    --name <container_name> \
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

  To revoke roles for a container, use the [updateAccessBindings](../containers/api-ref/Container/updateAccessBindings.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/UpdateAccessBindings](../containers/api-ref/grpc/Container/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the [subject](../../iam/concepts/access-control/index.md#subject) type and ID under `subject`.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}