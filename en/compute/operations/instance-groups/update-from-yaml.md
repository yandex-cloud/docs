# Edit an instance group based on the specification in YAML format

To edit an [instance group](../../concepts/instance-groups/index.md) based on a [specification](../../concepts/instance-groups/specification.md) in YAML format:

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  Run the following command:

  ```
  {{ yc-compute-ig }} update --file specification.yaml
  ```

  For more information about the `{{ yc-compute-ig}} update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance-group/update.md).

- API

  Use the call [InstanceGroupService/UpdateFromYaml](../../api-ref/grpc/instance_group_service.md#UpdateFromYaml) from the gRPC API or the method [updateFromYaml](../../api-ref/InstanceGroup/updateFromYaml.md) of the `InstanceGroup` resource in the REST API.

{% endlist %}

