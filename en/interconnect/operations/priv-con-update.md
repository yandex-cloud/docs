---
title: How to update private connection parameters in {{ interconnect-name }}
description: Follow this guide to update private connection parameters in {{ interconnect-name }}.
---

# Updating private connection parameters

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

Currently, you can update the following private connection parameters:
* `new-name`: Private connection name
* `description`: Private connection description
* `trunk-id`
* `vlan-id`
* `ipv4-peering`: Group of IP/BGP connectivity parameters

For example, to update the `vlan-id` parameter value in your private connection, complete the steps below.

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for updating a [private connection](../concepts/priv-con.md):

      ```bash
      yc cic private-connection update  --help
      ```

  1. Update the `vlan-id` parameter value for your private connection:

      ```bash
      yc cic private-connection update cca59**********dvjir \
        --vlan-id 201 \
        --async
      ```

      Expected result:

      ```text
      id: al4r9**********4613n
      description: private connection update
      created_at: "2025-04-08T21:21:33.106772882Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-08T21:21:33.106772882Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.UpdatePrivateConnectionMetadata
        private_connection_id: cca59**********dvjir
      ```

  1. Check the updated parameter value after the operation is complete:

     ```bash
     yc cic private-connection get cca59**********dvjir
     ```

{% endlist %}

