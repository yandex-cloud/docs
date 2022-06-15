# Edit an instance group based on the specification in YAML format

To update an [instance group](../../concepts/instance-groups/index.md) based on the [specification](../../concepts/instance-groups/specification.md) in YAML format:

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

   Use the [InstanceGroupService/UpdateFromYaml](../../api-ref/grpc/instance_group_service.md#UpdateFromYaml) gRPC API call or the [updateFromYaml](../../api-ref/InstanceGroup/updateFromYaml.md) method of the REST API `InstanceGroup` resource.

{% endlist %}