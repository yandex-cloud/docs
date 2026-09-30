---
title: Assigning roles for a container
description: Follow this guide to assign roles for a container.
---

# Assigning roles for a container

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command to assign a [role](../security/index.md) for a container:

  ```bash
  yc serverless container add-access-binding \
    --name <container_name> \
    --role <role> \
    --subject <subject_type>:<subject_ID>
  ```

  Where:

  * `--role`: [Role](../security/index.md#roles-list).
  * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

      {% cut "Subject designations" %}

      {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}

- API {#api}

  To assign roles for a container, use the [setAccessBindings](../containers/api-ref/Container/setAccessBindings.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/SetAccessBindings](../containers/api-ref/grpc/Container/setAccessBindings.md) gRPC API call. In the request body, set the `action` property to `ADD` and specify the [subject](../../iam/concepts/access-control/index.md#subject) type and ID under `subject`.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}