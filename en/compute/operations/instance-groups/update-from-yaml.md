# Editing an instance group based on the specification in YAML format

To update an [instance group](../../concepts/instance-groups/index.md) based on the [specification](../../concepts/instance-groups/specification.md) in YAML format:

{% list tabs %}

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   Run the command below by specifying the instance group name or ID and the YAML specification file path:

   ```
   {{ yc-compute-ig }} update <instance_group_name>|<instance_group_ID> --file specification.yaml
   ```

   For more information about the `{{ yc-compute-ig }} update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance-group/update.md).

- API

   Use the [updateFromYaml](../../api-ref/InstanceGroup/updateFromYaml.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/UpdateFromYaml](../../api-ref/grpc/instance_group_service.md#UpdateFromYaml) gRPC API call.

   To request the list of available instance groups, use the [listInstances](../../api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances) gRPC API call.

{% endlist %}