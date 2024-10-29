---
title: How to create a group of virtual machines in {{ compute-full-name }} based on a YAML specification
description: Follow this guide to create an instance group based on a YAML specification.
---

# Create an instance group based on the specification in YAML format

To create an [instance group](../../concepts/instance-groups/index.md) based on the [specification](../../concepts/instance-groups/specification.md) in YAML format:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  Run the following command:

  ```bash
  {{ yc-compute-ig }} create --file specification.yaml
  ```

  For more information about the `{{ yc-compute-ig}} create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance-group/create.md).

- API {#api}

  Use the [InstanceGroupService/CreateFromYaml](../../instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md) gRPC API call or the [createFromYaml](../../instancegroup/api-ref/InstanceGroup/createFromYaml.md) method of the REST API `InstanceGroup` resource.

{% endlist %}