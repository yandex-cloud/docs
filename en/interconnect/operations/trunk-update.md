---
title: How to update a trunk in {{ interconnect-name }}
description: Follow this guide to update parameters in a trunk in {{ interconnect-name }}.
---

# Updating trunk parameters

## Updating basic settings {#update}

Currently, you can only perform some operations to update the trunk on your own:
* Updating the trunk name: `new-name`.
* Update the trunk description in `description`.
* Changing [labels](../../resource-manager/concepts/labels.md) assigned to a trunk.
* Enable or disable trunk deletion protection: `deletion-protection`.

To update other trunk parameters, contact support.

For example, to change the trunk name, perform the following steps.

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/interconnect) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}**.
  1. In the row with the trunk, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens:

      1. Optionally, change the connection **{{ ui-key.yacloud.common.name }}**. The naming requirements are as follows:

          {% include [name-format](../../_includes/name-format.md) %}

          If you do not specify a name, the trunk name will be identical to the trunk [ID](../../api-design-guide/concepts/resources-identification.md).

      1. Optionally, change the connection **{{ ui-key.yacloud.common.description }}**.
      1. Optionally, change the [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md) assigned to the connection.
      1. Optionally, enable or disable the **{{ ui-key.yacloud.common.deletion-protection }}** setting based on whether you need to protect the connection from accidental deletion.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  With the CLI, you can edit the following trunk parameters:

  * Name (`--new-name`).
  * Description (`--description`).
  * Labels (`--labels`).
  * Deletion protection (`--deletion-protection`).

  If you use `--labels`, the current labels will be completely overwritten.

  1. See the description of the CLI command for updating [trunk](../concepts/trunk.md) parameters:

      ```bash
      yc cic trunk-connection update --help
      ```

  1. Change the trunk name:

      ```bash
      yc cic trunk-connection update cf3dcodot14p******** \
        --new-name my-new-trunk-name \
        --async
      ```

      Expected result:

      ```text
      id: bd6g2l17c8sv********
      description: trunk connection update
      created_at: "2025-03-27T09:43:00.880696489Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-03-27T09:43:00.969837738Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.UpdateTrunkConnectionMetadata
        trunk_connection_id: cf3dcodot14p********
      ```

  1. Wait for the operation to complete and make sure the trunk name has changed:

      ```bash
      yc cic trunk-connection get cf3dcodot14p********
      ```

{% endlist %}

## Updating connection capacity {#capacity}

To update the [trunk capacity](../concepts/capacity.md), create a [support ticket]({{ link-console-support }}).

Below is a ticket example:

```text
Subject: [CIC] Updating the trunk capacity.

Please update the trunk capacity.
from 500 Mbit/s to 1 Gbit/s.

Trunk ID: euus5dfgchu23b******
```

Once the capacity is updated, support will notify you that the operation is complete. Billing will reflect the new capacity right after you update the connection parameter.
