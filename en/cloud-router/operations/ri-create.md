---
title: How to create a routing instance in {{ cr-name }}
description: Follow this guide to create a routing instance in {{ cr-name }}.
---

# Create a routing instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cloud-router.editor](../security/index.md#cloudrouter-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for creating a [routing instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance create --help
      ```

  1. Create a routing instance in the specified folder:

      {% note info %}

      To simplify maintenance, we recommend creating the routing instance in the same folder where the trunk and private connection were previously created.

      {% endnote %}

      ```bash
      yc cloudrouter routing-instance create --name ri1 \
        --description "Routing instance 1" \ 
        --folder-id b1gqf**********jiz2w \
        --async
      ```

      Expected result:

      ```text
      id: fokrf**********ml058
      description: routing instance create
      created_at: "2025-04-16T12:43:54.507531644Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-16T12:43:54.507531644Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.CreateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

  1. To check the result of creating a routing instance:
     
      ```text
      yc cloudrouter routing-instance get c3l87**********1dpin
      id: c3l87**********1dpin
      name: ri1
      description: Routing instance 1
      folder_id: b1gqf**********jiz2w
      region_id: ru-central1
      status: ACTIVE
      created_at: "2025-04-16T12:43:55Z"
      ```

      Where:
      * `id`: Routing instance ID.
      * `name`: Routing instance name.
      * `description`: Routing instance description.
      * `folder_id`: ID of the cloud folder the routing instance was created in.
      * `region_id`: Cloud region the routing instance was created in.
      * `status`: Resource state. Target state: `ACTIVE`. When being created, it may be in the `CREATING` state.
      * `created_at`: Date and time of resource creation.
      * `async`: Running the operation in asynchronous mode. This is the recommended mode for all operations that involve changes to resources.

{% endlist %}

