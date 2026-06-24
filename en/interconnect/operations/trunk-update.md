---
title: How to update a trunk in {{ interconnect-name }}
description: Follow this guide to update parameters in a trunk in {{ interconnect-name }}.
---

# Updating trunk parameters

Currently, users can perform limited operations when updating a trunk:
* Updating the trunk name: `new-name`.
* Update the trunk description in `description`.
* Changing [labels](../../resource-manager/concepts/labels.md) assigned to a trunk.
* Set or remove the trunk deletion protection flag, `deletion-protection`.

To update other trunk parameters, e.g., [change the trunk capacity](../tutorials/trunk-capacity-change.md), you still need to contact support.

For example, to change the trunk name, follow these steps:

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
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

      Result:



{% endlist %}
