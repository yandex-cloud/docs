---
title: How to update a trunk in {{ interconnect-name }}
description: Follow this guide to update parameters in a trunk in {{ interconnect-name }}.
---

# Updating trunk parameters

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

Currently, users can perform limited operations when updating a trunk:
* Update the trunk name in `new-name`.
* Update the trunk description in `description`.
* Set or remove the trunk deletion protection flag, `deletion-protection`.

To update other trunk parameters, e.g., [change the trunk capacity](../tutorials/trunk-capacity-change.md), you still need to contact support.

For example, to change the trunk name, follow these steps:

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for updating [trunk](../concepts/trunk.md) parameters:

      ```bash
      yc cic trunk-connection update  --help
      ```

  1. Change the trunk name:

      ```bash
      yc cic trunk-connection update cf3td**********nufvr \
        --new-name my-new-m9-trunk \
        --async
      ```

      Result:

      ```text
      id: cf3td**********nufvr
      description: Trunk M9
      created_at: "2025-03-27T09:43:00.880696489Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-03-27T09:43:00.969837738Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.UpdateTrunkConnectionMetadata
        trunk_connection_id: cf3td**********nufvr
      response:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.TrunkConnection
        id: cf3td**********nufvr
        name: my-new-m9-trunk
        description: Trunk M9
        folder_id: yc.vpc.cic.api.internal-resources
        region_id: ru-central1
        single_port_direct_joint:
          transceiver_type: TRANSCEIVER_TYPE_10GBASE_LR
          port_name: 25GE1/0/12
        point_of_presence_id: ru-msk-m9-0
        capacity: CAPACITY_10_GBPS
        status: ACTIVE
      ```

{% endlist %}

