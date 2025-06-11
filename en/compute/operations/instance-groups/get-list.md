---
title: How to get a list of instance groups in {{ compute-full-name }}
description: Follow this guide to get a list of instance groups.
---

# Getting a list of instance groups

To get a list of instance groups:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing the instance group in question.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for using an instance group:

      ```bash
      {{ yc-compute-ig }} --help
      ```

  1. Get a list of instance groups in the default folder:

      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

- API {#api}

  Use the [list](../../instancegroup/api-ref/InstanceGroup/list.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/List](../../instancegroup/api-ref/grpc/InstanceGroup/list.md) gRPC API call.

  To request a list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}
