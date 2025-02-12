---
title: How to create an instance group in {{ compute-full-name }} based on a YAML specification
description: Follow this guide to create an instance group based on a YAML specification.
---

# Creating an instance group based on a YAML specification

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To be able to create, update, and delete VMs in the group, [assign](../../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../security/index.md#compute-editor) role to the service account.

If you want to integrate an instance group with a [{{ network-load-balancer-full-name }}](../../../network-load-balancer/), you also need to assign the [load-balancer.editor](../../../network-load-balancer/security/index.md#load-balancer-editor) role to the service account.

To integrate an instance group with an L7 load balancer from [{{ alb-full-name }}](../../../application-load-balancer/), assign the [alb.editor](../../../application-load-balancer/security/index.md#alb-editor) role to the service account.

To create an [instance group](../../concepts/instance-groups/index.md) based on the [specification](../../concepts/instance-groups/specification.md) in YAML format:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  {{ yc-compute-ig }} create --file specification.yaml
  ```

  For more information about the `{{ yc-compute-ig}} create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance-group/create.md).

- API {#api}

  Use the [InstanceGroupService/CreateFromYaml](../../instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md) gRPC API call or the [createFromYaml](../../instancegroup/api-ref/InstanceGroup/createFromYaml.md) method of the REST API `InstanceGroup` resource.

{% endlist %}