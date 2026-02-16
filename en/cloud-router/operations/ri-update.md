---
title: How to update routing instance parameters in {{ cr-name }}
description: Follow this guide to update routing instance parameters in {{ cr-name }}.
---

# Updating routing instance parameters

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

Currently, you can update the following routing instance parameters:
* `new-name`: Private connection name
* `description`: Private connection description

{% note info %}

When updating announcements of IP prefixes or adding (deleting) private connections in a routing instance, we recommend using [separate commands](cr-cic-ops.md#ri), not the `--vpc-net` and `--cic-prc` options of the update command.

{% endnote %}

For example, to update the `description` parameter value of a routing instance, follow the steps below.

{% note info %}

You need the [cloud-router.editor](../security/index.md#cloudrouter-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for updating a [routing instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance update  --help
      ```

  1. Update the `description` parameter value for the routing instance:

      ```bash
      yc cloudrouter routing-instance update c3l87**********1dpin \
        --description "My new RI description" \
        --async
      ```

      Expected result:

      ```text
      id: al4r9**********4613n
      description: routing instance update
      created_at: "2025-04-08T21:21:33.106772882Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-08T21:21:33.106772882Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

  1. Check the updated parameter value after the operation is complete:

     ```bash
     yc cloudrouter routing-instance get c3l87**********1dpin
     ```

{% endlist %}

