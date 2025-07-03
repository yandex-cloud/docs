---
title: How to delete IP prefixes from a routing instance in {{ cr-name }}
description: Follow this guide to delete IP prefixes from a routing instance in {{ cr-name }}.
---

# Deleting IP prefixes from a routing instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cloud-router.editor](../security/index.md#cloudrouter-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for deleting IP prefixes from a [routing instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance remove-prefixes --help
      ```

  1. Checking the routing instance configuration and the list of IP prefixes:

     ```bash
     yc cloudrouter routing-instance upsert-prefixes c3l87**********1dpin
     ```

     Expected result:




  1. Deleting IP prefixes from a routing instance:




     Expected result:

     ```text
      id: al457**********njn6p
      description: routing instance remove prefixes
      created_at: "2025-03-24T15:24:15.817401507Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-03-24T15:24:15.817401507Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

     Where:
      * `id`: ID of the operation performed with a routing instance.
      * `description`: Description of the operation in progress.
      * `created_by`: ID of the subject running the operation.
      * `async`: Running the operation in asynchronous mode. We recommend using this mode for all operations that modify your resources.


  1. Check the modified routing instance configuration after the changes:

     ```bash
     yc cloudrouter routing-instance get c3l87**********1dpin
     ```

     Expected result:




     Where:
      * `id`: Routing instance ID.
      * `name`: Routing instance name.
      * `description`: Routing instance description.
      * `folder_id`: ID of the cloud folder the routing instance was created in.
      * `region_id`: Region of the cloud the routing instance was created in.
      * `vpc_info`: List of IP prefixes by availability zone. For each zone, prefixes are shown separately.
      * `cic_private_connection_info`: List of private connections connected to the routing instance.
      * `status`: Resource state. The target state is `ACTIVE`. When being updated, it may be in the `UPDATING` state.
      * `created_at`: Date and time of resource creation.

{% endlist %}

