---
title: How to add a private connection to a routing instance in {{ cr-name }}
description: Follow this guide to add a private connection to a routing instance in {{ cr-name }}.
---

# Adding a private connection to a routing instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cloud-router.editor](../security/index.md#cloudrouter-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for adding a [private connection](../../interconnect/concepts/priv-con.md) to a [routing instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance add-private-connection --help
      ```

  1. Adding a private connection to a routing instance:

     ```bash
     yc cloudrouter routing-instance add-private-connection c3l87**********1dpin \
       --cic-prc b1gqf**********jiz2w \ 
       --async
     ```

     Expected result:

     ```text
      id: fokrf**********ml058
      description: routing instance add private connection
      created_at: "2025-04-16T12:43:54.507531644Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-16T12:43:54.507531644Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

     Where:
      * `id`: ID of the operation performed with a routing instance.
      * `created_by`: ID of the subject running the operation.


  1. Checking the modified routing instance configuration:

     ```bash
     yc cloudrouter routing-instance get c3l87**********1dpin
     ```

     Expected result:

     ```
     id: c3l87**********1dpin
     name: ri1-preprod
     description: Routing instance 1
     folder_id: b1gqf**********jiz2w
     region_id: ru-central1
     cic_private_connection_info:
       - cic_private_connection_id: cf3td**********nufvr
     status: ACTIVE
     created_at: "2025-03-19T13:35:56Z"
     ```

     Where:
      * `id`: Routing instance ID.
      * `name`: Routing instance name.
      * `description`: Routing instance description.
      * `folder_id`: ID of the cloud folder the routing instance was created in.
      * `region_id`: Cloud region the routing instance was created in.
      * `cic_private_connection_info`: List of private connections in this routing instance.
      * `status`: Resource state. Target state: `ACTIVE`. When being updated, it may be in the `UPDATING` state.
      * `created_at`: Date and time of resource creation.
      * `async`: Running the operation in asynchronous mode. This is the recommended mode for all operations that involve changes to resources.

{% endlist %}

