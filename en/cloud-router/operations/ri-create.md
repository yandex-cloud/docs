---
title: How to create a virtual router in {{ cr-name }}
description: Follow this guide to create a virtual router in {{ cr-name }}.
---

# Creating a virtual router

{% note info %}

You need the [cloud-router.editor](../security/index.md#cloudrouter-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [virtual router](../concepts/routing-instance.md).
  1. [Navigate]({{ link-console-main }}/link/cloud-router) to **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. Click **{{ ui-key.yacloud.cloud-router.router.create-router_v4cPC }}**.
  1. Enter a name and description for your virtual router.
  1. Optionally, add [labels](../../resource-manager/concepts/labels.md):

      1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
      1. Add a label in `key: value` format.
      1. Press **Enter**.

  1. Optionally, enable **{{ ui-key.yacloud.common.deletion-protection }}** to protect your virtual router from accidental deletion.
  1. In the **Private connections** field, select the [private connections](../../interconnect/concepts/priv-con.md) or specify their IDs.
  1. In the **{{ ui-key.yacloud.cloud-router.router.networks_fbzKL }}** field, select the [networks](../../vpc/concepts/network.md).
  1. Add the IP prefixes in the section that appears dedicated to the network and its subnets.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. See the description of the CLI command for creating a [virtual router](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance create --help
      ```

  1. Create a virtual router in the specified folder:

      {% note info %}

      To simplify maintenance, we recommend creating the virtual router in the same folder where the trunk and private connection were previously created.

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

  1. To check the result of creating a virtual router:

      ```text
      yc cloudrouter routing-instance get c3l87**********1dpin
      id: c3l87**********1dpin
      name: ri1
      description: Routing instance 1
      folder_id: b1gqf**********jiz2w
      region_id: {{ region-id }}
      status: ACTIVE
      created_at: "2025-04-16T12:43:55Z"
      ```

      Where:
      * `id`: Virtual router ID.
      * `name`: Virtual router name.
      * `description`: Virtual router description.
      * `folder_id`: ID of the cloud folder the virtual router was created in.
      * `region_id`: Region of the cloud the virtual router was created in.
      * `status`: Resource state. Target state: `ACTIVE`. When being created, it may be in the `CREATING` state.
      * `created_at`: Date and time of resource creation.
      * `async`: Running the operation in asynchronous mode. This is the recommended mode for all operations that involve changes to resources.

{% endlist %}
