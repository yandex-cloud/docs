---
title: How to update virtual router settings in {{ cr-name }}
description: Follow this guide to update virtual router settings in {{ cr-name }}.
---

# Updating virtual router settings

{% note info %}

You need the [cloud-router.editor](../security/index.md#cloudrouter-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [virtual router](../concepts/routing-instance.md).
  1. [Navigate]({{ link-console-main }}/link/cloud-router) to **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. In the virtual router row, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Enter a new name and description for your virtual router.
  1. Add or delete [labels](../../resource-manager/concepts/labels.md).   
  1. Enable or disable **{{ ui-key.yacloud.common.deletion-protection }}** to protect your virtual router from accidental deletion.
  1. Add or delete [private connections](../../interconnect/concepts/priv-con.md) in the **Private connections** field.
  1. In the **{{ ui-key.yacloud.cloud-router.router.networks_fbzKL }}** field, add or delete [networks](../../vpc/concepts/network.md) and IP prefixes.

- CLI {#cli}

  Currently, you can update the following virtual router settings via the CLI:
  * `new-name`: Private connection name.
  * `description`: Private connection description.
  
  {% note info %}
  
  When updating IP prefix announcements or adding or deleting private connections in a virtual router, use [separate commands](cr-cic-ops.md#ri) instead of the `--vpc-net` and `--cic-prc` update command options.
  
  {% endnote %}
  
  For example, to update the virtual router `description`, follow the steps below:

  1. View the description of the CLI command for updating a [virtual router](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance update  --help
      ```

  1. Provide a new `description` for the virtual router:

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
