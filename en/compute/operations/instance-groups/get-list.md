---
title: "How to get a list of instance groups in {{ compute-full-name }}"
description: "Follow this guide to get a list of instance groups."
---

# Get a list of instance groups

To get a list of instance groups:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open the folder with the appropriate instance group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's use instance group command:

      ```
      {{ yc-compute-ig }} --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

- API {#api}

   Use the [list](../../api-ref/InstanceGroup/list.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/List](../../api-ref/grpc/instance_group_service.md#List) gRPC API call.

   To request the list of available instance groups, use the [listInstances](../../api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances) gRPC API call.

{% endlist %}
