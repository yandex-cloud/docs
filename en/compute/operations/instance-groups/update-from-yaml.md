---
title: How to update an instance group in {{ compute-full-name }} based on a YAML specification
description: Follow this guide to update an instance group based on a YAML specification.
---

# Editing an instance group based on a YAML specification

To update an [instance group](../../concepts/instance-groups/index.md) based on the [specification](../../concepts/instance-groups/specification.md) in YAML format:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  Run the command below, specifying the instance group name or ID and the YAML specification file path:
  
  ```bash
  {{ yc-compute-ig }} update <instance_group_name_or_ID> --file specification.yaml
  ```

  For more information about the `{{ yc-compute-ig }} update` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance-group/update.md).

- API {#api}

  Use the [updateFromYaml](../../instancegroup/api-ref/InstanceGroup/updateFromYaml.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/UpdateFromYaml](../../instancegroup/api-ref/grpc/InstanceGroup/updateFromYaml.md) gRPC API call.

  To request the list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}